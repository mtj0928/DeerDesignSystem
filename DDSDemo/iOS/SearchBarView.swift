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
                                .onAppear {
                                    queue.add(CustomNotificationRequest(identifier: "xxx"))
                                }
                        }
                        .background(DDSColor.primaryBackground.swiftUIColor)
                    })
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomNotificationRequest: View, InAppNotificationRequest {
    let identifier: String
    var view: AnyView { AnyView(self) }
    var duration: TimeInterval? = nil

    @State var counter = 0

    var body: some View {
        HStack {
            Text("\(counter)")
            Spacer()
            Button("Tap", action: { counter += 1 })
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(DDSColor.deerGreen.swiftUIColor)
                .cornerRadius(6)
                .foregroundColor(.white)
        }
        .padding()
        .background(DDSColor.notificationBackground.swiftUIColor)
    }
}


struct SearchBarView_Provider: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
