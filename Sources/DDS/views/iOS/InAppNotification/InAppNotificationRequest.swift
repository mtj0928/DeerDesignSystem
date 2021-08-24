import SwiftUI

public protocol InAppNotificationRequest {
    var identifier: String { get }
    var icon: AnyView? { get }
    var title: String? { get }
    var body: String? { get }
}

public struct StandardInAppNotificationRequest: InAppNotificationRequest {
    public let identifier: String
    public let icon: AnyView?
    public let title: String?
    public let body: String?

    public init<Icon: View>(identifier: String, icon: Icon, title: String?, body: String?) {
        self.identifier = identifier
        self.icon = AnyView(icon)
        self.title = title
        self.body = body
    }

    public init(identifier: String, title: String?, body: String?) {
        self.identifier = identifier
        self.icon = nil
        self.title = title
        self.body = body
    }
}
