#if os(iOS)
import SwiftUI
import UIKit
import Combine

public class InAppNotificationCenter {

    private static var centers: [String: InAppNotificationCenter] = [:]

    public let queue = InAppNotificationQueue()
    public var delegate: InAppNotificationDelegte? = nil {
        didSet { reload() }
    }

    private let window: OverlayWindow
    private let layer: UIHostingController<InAppNotificationLayer>
    private let previousKeyWindow: UIWindow?
    private var cancelable: AnyCancellable?

    private init(for windowScene: UIWindowScene) {
        let layerView = InAppNotificationLayer(queue: queue)

        self.previousKeyWindow = windowScene.windows.first(where: \.isKeyWindow)

        let hostingController = UIHostingController(rootView: layerView)
        hostingController.view.backgroundColor = .clear
        self.layer = hostingController

        self.window = OverlayWindow(ignoreView: hostingController.view)
        window.rootViewController = hostingController
        window.windowLevel = .normal
        window.windowScene = windowScene
        window.makeKeyAndVisible()

        previousKeyWindow?.makeKey()

        self.cancelable = queue.$current
            .sink { [weak self] request in
                if request == nil {
                    self?.previousKeyWindow?.makeKey()
                } else {
                    self?.window.makeKey()
                }
        }
    }

    private func reload() {
        let layerView = InAppNotificationLayer(queue: queue, delegate: delegate)
        layer.rootView = layerView
        layer.view.backgroundColor = .clear
    }

    public static func resolve(for windowSenece: UIWindowScene) -> InAppNotificationCenter {
        if let center = centers[windowSenece.session.persistentIdentifier] {
            return center
        }
        let center = InAppNotificationCenter(for: windowSenece)
        centers[windowSenece.session.persistentIdentifier] = center
        return center
    }
}
#endif
