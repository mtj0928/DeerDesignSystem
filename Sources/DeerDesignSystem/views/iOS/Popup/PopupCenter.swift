#if os(iOS)
import SwiftUI

public class PopupCenter {

    private static var centers: [String: PopupCenter] = [:]

    public var popup: Popup? {
        didSet { reload() }
    }

    private let window: OverlayWindow?
    private let layer: UIHostingController<PopupLayer>?
    private let previousKeyWindow: UIWindow?

    public init() {
        window = nil
        layer = nil
        previousKeyWindow = nil
    }

    private init(for windowScene: UIWindowScene) {
        self.previousKeyWindow = windowScene.windows.first(where: \.isKeyWindow)

        let hostingController = UIHostingController(rootView: PopupLayer(popup: nil))
        hostingController.view.backgroundColor = .clear
        self.layer = hostingController

        self.window = OverlayWindow(ignoreView: hostingController.view)
        window?.rootViewController = hostingController
        window?.windowLevel = .normal
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()

        previousKeyWindow?.makeKey()
    }

    func reload() {
        layer?.rootView = PopupLayer(popup: popup)
        layer?.view.backgroundColor = .clear
    }

    public static func resolve(for windowSenece: UIWindowScene) -> PopupCenter {
        if let center = centers[windowSenece.session.persistentIdentifier] {
            return center
        }
        let center = PopupCenter(for: windowSenece)
        centers[windowSenece.session.persistentIdentifier] = center
        return center
    }
}

public class PopupPreviewCenter: PopupCenter, ObservableObject {

    public static let shared = PopupPreviewCenter()

    override func reload() {
        objectWillChange.send()
    }
}

#endif
