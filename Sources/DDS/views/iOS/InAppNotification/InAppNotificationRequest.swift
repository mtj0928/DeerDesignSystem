import SwiftUI

public protocol InAppNotificationRequest {
    var identifier: String { get }
    var view: AnyView { get }
}

extension InAppNotificationRequest {
    public var duration: TimeInterval { 3.0 }
}
