import SwiftUI

// MARK: - InAppNotificationDelegte

public struct InAppNotificationDelegateKey: EnvironmentKey {
    public static let defaultValue: InAppNotificationDelegte? = nil
}

extension EnvironmentValues {
    
    public var inAppNotificationDelegate: InAppNotificationDelegte? {
        get { self[InAppNotificationDelegateKey.self] }
        set { self[InAppNotificationDelegateKey.self] = newValue }
    }
}

#if os(iOS)

// MARK: - InAppNotificationQueue

public struct InAppNotificationQueueKey: EnvironmentKey {

    @available(iOS 14.0, *)
    public static let defaultValue = InAppNotificationQueue()
}

extension EnvironmentValues {

    @available(iOS 14.0, *)
    public var inAppNotificationQueue: InAppNotificationQueue {
        get { self[InAppNotificationQueueKey.self] }
        set { self[InAppNotificationQueueKey.self] = newValue }
    }
}

#endif
