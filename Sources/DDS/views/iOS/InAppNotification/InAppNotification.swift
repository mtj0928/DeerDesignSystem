import SwiftUI

@available(iOS 14.0, *)
public struct InAppNotification: View {
    let request: InAppNotificationRequest

    public init(request: InAppNotificationRequest) {
        self.request = request
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if let icon = request.icon {
                icon.frame(width: 53, height: 53)
                    .padding(.trailing, 8)
            } else {
                Spacer().frame(width: 8)
            }

            VStack(alignment: .leading, spacing: 2) {
                if let title = request.title {
                    Text(title)
                        .preferredFont(for: .callout, weight: .bold)
                        .foregroundColor(DDSColor.primaryText.swiftUIColor)
                }

                if let body = request.body {
                    Text(body)
                        .preferredFont(for: .footnote, weight: .regular)
                        .lineSpacing(0)
                        .foregroundColor(DDSColor.primaryText.swiftUIColor)
                        .lineLimit(2)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(13)
        .background(DDSColor.notificationBackground.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 6)
    }
}

struct InAppNotification_Preview: PreviewProvider {

    static var previews: some View {
        Group {
            ZStack {
                DDSColor.primaryBackground.swiftUIColor
                    .ignoresSafeArea()
                VStack {
                    InAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            icon: ZStack {
                                Circle().foregroundColor(.red)
                                Image(systemSymbol: .airpodspro).foregroundColor(.white)
                            },
                            title: "No AirPods Pro",
                            body: "Connection of AirPodsPro was lost"
                        )
                    )
                    InAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: "You received a new comment.",
                            body: "Tom: Hello!"
                        )
                    )
                    InAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: nil,
                            body: "Only body text."
                        )
                    )
                    InAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: "Only title text",
                            body: nil
                        )
                    )
                    Spacer()
                }
                .padding()
            }

            ZStack {
                DDSColor.primaryBackground.swiftUIColor
                    .ignoresSafeArea()
                VStack {
                    InAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            icon: Image(systemSymbol: .airpodspro),
                            title: "No AirPods Pro",
                            body: "Connection of AirPodsPro was lost"
                        )
                    )
                    InAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: "You received a new comment.",
                            body: "Tom: Hello!"
                        )
                    )
                    InAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: nil,
                            body: "Only body text."
                        )
                    )
                    InAppNotification(
                        request: StandardInAppNotificationRequest(
                            identifier: "XXX",
                            title: "Only title text",
                            body: nil
                        )
                    )
                    Spacer()
                }
                .padding()
            }
            .preferredColorScheme(.dark)
        }
    }
}
