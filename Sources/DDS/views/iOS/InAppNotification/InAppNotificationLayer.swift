import SwiftUI

public struct InAppNotificationLayer: View {

    @Environment(\.inAppNotificationDelegate) var delegate
    @ObservedObject var queue: InAppNotificationQueue
    @ObservedObject var stateMachine = InAppNotificationStateMachine()

    public init(queue: InAppNotificationQueue) {
        self.queue = queue
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack {
                if let request = queue.current,
                   stateMachine.currentCanShowNotification {
                    VStack {
                        Spacer().frame(height: proxy.safeAreaInsets.top + 8)
                        InAppNotification(request: request)
                            .onTapGesture {
                                delegate?.notification(didTap: request)
                                self.stateMachine.transition(to: .hiding)
                            }
                            .gesture(gesture)
                            .onAppear {
                                stateMachine.transition(to: .showing)
                            }
                            .onDisappear {
                                stateMachine.transition(to: .standby)
                                queue.next()
                            }
                    }
                    .offset(y: -proxy.safeAreaInsets.top)
                    .offset(y: stateMachine.offset)
                    .transition(.move(edge: .top))
                    .animation(.easeInOut)
                }
                Spacer()
            }
            .frame(width: proxy.size.width)
        }
        .padding(.horizontal)
    }

    private var gesture: some Gesture {
        DragGesture(minimumDistance: .zero)
            .onChanged({ value in
                self.stateMachine.offset = self.calculateOffSet(for: value)
                self.stateMachine.transition(to: .dragging)
            })
            .onEnded({ value in
                let diff = value.predictedEndLocation.y - value.startLocation.y
                if diff <= -20 {
                    self.stateMachine.transition(to: .hiding)
                } else {
                    self.stateMachine.transition(to: .showing)
                }
            })
    }

    func calculateOffSet(for value: DragGesture.Value) -> CGFloat {
        let diff = value.location.y - value.startLocation.y
        if diff <= 0 {
            return diff
        }
        return diff / 20
    }
}


struct InAppNotificationLayer_Preview: PreviewProvider {

    static var previews: some View {
        let queue = InAppNotificationQueue()

        return ZStack {
            GeometryReader { proxy in
                ScrollView {
                    Alignment {
                        Button("show notification") {
                            let request = StandardInAppNotificationRequest(
                                identifier: "xxx",
                                icon: ZStack {
                                    Circle().foregroundColor(DDSColor.deerGreen.swiftUIColor)
                                        .layoutPriority(1)
                                    Alignment {
                                        Image(systemSymbol: .bellBadgeFill)
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .foregroundColor(.white)
                                    }
                                },
                                title: "New Notifiction",
                                body: "You received a new notification. \nCheck it."
                            )
                            queue.add(request)
                        }
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            InAppNotificationLayer(queue: queue)
        }
        .preferredColorScheme(.dark)
    }
}
