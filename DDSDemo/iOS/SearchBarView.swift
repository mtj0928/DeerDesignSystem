import SwiftUI
import DDS

struct SearchBarView: View {
    @Environment(\.inAppNotificationQueue) var queue
    @State var text: String = ""

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                DDSColor.primaryBackground.swiftUIColor.ignoresSafeArea()
                ScrollView {
                    VStack {
                        SearchBar(
                            placeHolder: Text("Type something"),
                            input: $text
                        ) {
                            queue.add(StandardInAppNotificationRequest(
                                identifier: UUID().uuidString,
                                title: nil,
                                body: "Input text will be notified few seconds later."
                            ))
                            queue.add(StandardInAppNotificationRequest(
                                identifier: UUID().uuidString,
                                icon: ZStack {
                                    Circle().foregroundColor(DDSColor.deerGreen.swiftUIColor)
                                    Image(systemSymbol: .bellBadgeFill)
                                },
                                title: "Input text in search bar",
                                body: text
                            ))
                        }
                        Spacer()
                    }
                    .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct SearchBarView_Provider: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
