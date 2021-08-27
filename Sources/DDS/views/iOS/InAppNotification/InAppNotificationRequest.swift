import SwiftUI

public protocol InAppNotificationRequest {
    var identifier: String { get }
    var view: AnyView { get }
}
