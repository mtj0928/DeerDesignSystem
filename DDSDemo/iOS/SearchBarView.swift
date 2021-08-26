import SwiftUI
import DDS

struct SearchBarView: View {
    @Environment(\.inAppNotificationQueue) var queue
    @State var text: String = ""

    @State var isPrese = false

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
                                    Image(systemSymbol: .bellBadgeFill).foregroundColor(.white)
                                },
                                title: "Input text in search bar",
                                body: text
                            ))
                        }
                        Spacer()
                        BottomFullFillButton(text: "Show modal view") {
                            isPrese = true
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .foregroundColor(DDSColor.deerGreen.swiftUIColor)
                    }
                    .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
                    .sheet(isPresented: $isPrese, content: {
                        Alignment {
                            Text("たとえModalであっても変わらず上に通知が表示されます")
                                .foregroundColor(DDSColor.primaryText.swiftUIColor)
                                .padding()
                        }
                        .background(DDSColor.primaryBackground.swiftUIColor)
                    })
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
