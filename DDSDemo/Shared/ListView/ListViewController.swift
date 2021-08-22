import UIKit
import SwiftUI
import DDS

@available(iOS 14.0, *)
protocol ListItem: Hashable {
    func tapped()
}

@available(iOS 14.0, *)
protocol ListViewSection: Hashable {
    associatedtype Item: ListItem
    associatedtype ReusableView: ListViewReusableView

    var items: [Item] { get }
}

@available(iOS 14.0, *)
extension ListViewSection {
    var view: ReusableView? { nil }
}

protocol ListViewReusableView: UICollectionReusableView {
    associatedtype Section: ListViewSection
    func apply(section: Section)
}

@available(iOS 14.0, *)
protocol ListViewCell: UICollectionViewCell {
    associatedtype Item
    func apply(item: Item, at indexPath: IndexPath)
}

@available(iOS 14.0, *)
class ListViewController<
    Section: ListViewSection,
    Cell: ListViewCell
>: UIViewController where Cell.Item == Section.Item, Section.ReusableView.Section == Section {

    typealias Item = Cell.Item
    typealias CellRegistration = UICollectionView.CellRegistration<Cell, Item>
    typealias SectionRegistration = UICollectionView.SupplementaryRegistration<Section.ReusableView>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

    let collectionView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.headerMode = .supplementary
        configuration.backgroundColor = DDSColor.primaryBackground.color
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var dataSrouce: DataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    func apply(sections: [Section], animatingDifferences: Bool = true, completion: (() -> Void)? = nil) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSrouce?.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
    }
}

// MARK: - View

@available(iOS 14.0, *)
extension ListViewController {

    private func setupCollectionView() {
        view.addSubview(collectionView)

        let registration = CellRegistration { [weak self] cell, indexPath, item in
            guard let self = self else { return }

            cell.selectedBackgroundView = cell.selectedBackgroundView ?? UIView()
            cell.selectedBackgroundView?.backgroundColor = DDSColor.cellBackgroundSelected.color

            cell.backgroundView = UIView()
            cell.backgroundView?.backgroundColor = DDSColor.cellBackground.color

            if let hoastableView = cell as? HostableView {
                hoastableView.updateParentIfNeeded(in: self)
            }
            cell.apply(item: item, at: indexPath)
        }

        self.dataSrouce = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
        }

        let sectionRegistration = SectionRegistration(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] view, kind, indexPath in
            guard let self = self,
                  kind == UICollectionView.elementKindSectionHeader,
                  let dataSource = self.dataSrouce else { return }

            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            if let hostableView = view as? HostableView {
                hostableView.updateParentIfNeeded(in: self)
            }
            view.apply(section: section)
        }

        self.dataSrouce?.supplementaryViewProvider = { collectionView, _, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: sectionRegistration, for: indexPath)
        }

        collectionView.dataSource = dataSrouce

        setupLayout()
    }

    private func setupLayout() {
        view.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
    }
}
