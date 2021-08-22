import SwiftUI
import UIKit
import DDS

@available(iOS 14.0, *)
struct ListView<
    Section: ListViewSection,
    Cell: ListViewCell
>: UIViewControllerRepresentable where Cell.Item == Section.Item, Section.ReusableView.Section == Section {

    typealias UIViewControllerType = ListViewController<Section, Cell>

    let sections: [Section]

    func makeCoordinator() -> ListViewCoordinator<Section, Cell> {
        ListViewCoordinator(self)
    }

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.collectionView.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: ListViewController<Section, Cell>, context: Context) {
        uiViewController.apply(sections: sections)
    }
}

@available(iOS 14.0, *)
class ListViewCoordinator<
    Section: ListViewSection,
    Cell: ListViewCell
>: NSObject, UICollectionViewDelegate where Cell.Item == Section.Item, Section.ReusableView.Section == Section {

    let view: ListView<Section, Cell>

    init(_ view: ListView<Section, Cell>) {
        self.view = view

        super.init()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.sections[indexPath.section].items[indexPath.item].tapped()
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
