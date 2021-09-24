import SwiftUI

public struct StandardInAppNotificationRequest: InAppNotificationRequest {

    public let identifier: String
    public var view: AnyView {
        AnyView(StandardInAppNotification(request: self))
    }

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

@available(iOS 14.0, *)
struct StandardInAppNotification: View {
    let request: StandardInAppNotificationRequest

    init(request: StandardInAppNotificationRequest) {
        self.request = request
    }

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if let icon = request.icon {
                icon.frame(width: 53, height: 53)
                    .padding(.trailing, 8)
            } else {
                Spacer().frame(width: 8)
            }

            VStack(alignment: .leading, spacing: 4) {
                if let title = request.title {
                    Text(title)
                        .preferredFont(for: .callout, weight: .bold)
                        .foregroundColor(Color.dds.primaryText)
                }

                if let body = request.body {
                    Text(body)
                        .preferredFont(for: .footnote, weight: .regular)
                        .lineSpacing(0)
                        .foregroundColor(Color.dds.primaryText)
                        .lineLimit(2)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(13)
        .background(Color.dds.notificationBackground)
    }
}

struct InAppNotification_Preview: PreviewProvider {

    static var previews: some View {
        Group {
            ZStack {
                Color.dds
                    .primaryBackground
                    .ignoresSafeArea()
                VStack {
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            icon: ZStack {
                                Circle().foregroundColor(.red)
                                Image(systemSymbol: .airpodspro).foregroundColor(.white)
                            },
                            title: "No AirPods Pro",
                            body: "Connection of AirPodsPro was lost."
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            icon: ZStack {
                                Circle().foregroundColor(.red)
                                Image(systemSymbol: .airpodspro).foregroundColor(.white)
                            },
                            title: "No AirPods Pro",
                            body: "Connection of AirPodsPro was lost.Connection of AirPodsPro was lost."
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: "You received a new comment.",
                            body: "Tom: Hello!"
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: nil,
                            body: "Only body text."
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: "Only title text",
                            body: nil
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    Spacer()
                }
                .padding()
            }

            ZStack {
                Color.dds
                    .primaryBackground
                    .ignoresSafeArea()
                VStack {
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            icon: Image(systemSymbol: .airpodspro),
                            title: "No AirPods Pro",
                            body: "Connection of AirPodsPro was lost."
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: "You received a new comment.",
                            body: "Tom: Hello!"
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: nil,
                            body: "Only body text."
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    StandardInAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: "Only title text",
                            body: nil
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 6)
                    Spacer()
                }
                .padding()
            }
            .preferredColorScheme(.dark)
        }
    }
}
