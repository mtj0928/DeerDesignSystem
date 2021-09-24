import SwiftUI
import DeerDesignSystem

struct SearchBarView: View {
    @Environment(\.inAppNotificationQueue) var queue
    @State var text: String = ""

    @State var isPrese = false

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.dds.primaryBackground.ignoresSafeArea()
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
                                    Circle().foregroundColor(Color.dds.deerGreen)
                                    Image(systemSymbol: .bellBadgeFill).foregroundColor(.white)
                                },
                                title: "Input text in search bar",
                                body: text
                            ))
                        }
                        Spacer()
                        FullFillButton(text: "Show modal view") {
                            isPrese = true
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .foregroundColor(Color.dds.deerGreen)
                    }
                    .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
                    .sheet(isPresented: $isPrese, content: {
                        Alignment {
                            Text("たとえModalであっても変わらず上に通知が表示されます")
                                .foregroundColor(Color.dds.primaryText)
                                .padding()
                                .onAppear {
                                    queue.add(CustomNotificationRequest(identifier: "xxx"))
                                }
                        }
                        .background(Color.dds.primaryBackground)
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
    let duration: TimeInterval? = nil

    @State var counter = 0

    var body: some View {
        HStack {
            Text("\(counter)")
            Spacer()
            Button("Tap", action: { counter += 1 })
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color.dds.deerGreen)
                .cornerRadius(6)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.dds.notificationBackground)
    }
}


struct SearchBarView_Provider: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
