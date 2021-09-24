#if os(iOS)
import UIKit
import SwiftUI

@available(iOS 14.0, *)
public protocol HostableView: AnyObject {
    var hostingController: UIHostingController<AnyView> { get }
    var parentController: UIViewController? { get set }
    var contentView: UIView { get }
}

@available(iOS 14.0, *)
extension HostableView {

    public func updateParentIfNeeded(in parentController: UIViewController) {
        self.parentController = parentController
        let requiresControllerMove = hostingController.parent != parentController
        if requiresControllerMove {
            parentController.addChild(hostingController)
        }

        if !self.contentView.subviews.contains(hostingController.view) {
            self.contentView.addSubview(hostingController.view)
            hostingController.view.backgroundColor = .clear
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false

            hostingController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            hostingController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            hostingController.view.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            hostingController.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }

        if requiresControllerMove {
            hostingController.didMove(toParent: parentController)
        }
    }

    public func updateLayout() {
        hostingController.view.invalidateIntrinsicContentSize()
        hostingController.view.layoutIfNeeded()
    }

}

@available(iOS 14.0, *)
public protocol HostingController: HostableView {
    associatedtype Label: View
    associatedtype Item

    var item: Item? { get set }

    @ViewBuilder var body: Label { get }

    var hostingController: UIHostingController<AnyView> { get }
    var parentController: UIViewController? { get set }
    var contentView: UIView { get }
}

@available(iOS 14.0, *)
extension HostingController {
    public func refresh() {
        hostingController.rootView = AnyView(body)
        updateLayout()
    }
}
#endif
