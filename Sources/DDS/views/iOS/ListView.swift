#if os(iOS)
import SwiftUI

@available(iOS 14.0, *)
public struct ListView<
    Section: ListViewSection,
    Cell: ListViewCell
>: UIViewControllerRepresentable where Cell.Item == Section.Item, Section.ReusableView.Section == Section {

    public typealias UIViewControllerType = ListViewController<Section, Cell>

    public let sections: [Section]

    public init(sections: [Section]) {
        self.sections = sections
    }

    public func makeCoordinator() -> ListViewCoordinator<Section, Cell> {
        ListViewCoordinator(self)
    }

    public func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.collectionView.delegate = context.coordinator
        return viewController
    }

    public func updateUIViewController(_ uiViewController: ListViewController<Section, Cell>, context: Context) {
        uiViewController.apply(sections: sections)
    }
}

@available(iOS 14.0, *)
public class ListViewCoordinator<
    Section: ListViewSection,
    Cell: ListViewCell
>: NSObject, UICollectionViewDelegate where Cell.Item == Section.Item, Section.ReusableView.Section == Section {

    let view: ListView<Section, Cell>

    init(_ view: ListView<Section, Cell>) {
        self.view = view

        super.init()
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.sections[indexPath.section].items[indexPath.item].tapped()
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
#endif
