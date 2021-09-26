import SwiftUI

#if os(iOS)
public struct PopupCenterKey: EnvironmentKey {

    public static let defaultValue: PopupCenter? = nil
}

extension EnvironmentValues {

    public var popupCenter: PopupCenter? {
        get { self[PopupCenterKey.self] }
        set { self[PopupCenterKey.self] = newValue }
    }
}
#endif

