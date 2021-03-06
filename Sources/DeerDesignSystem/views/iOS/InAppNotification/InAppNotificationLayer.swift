#if os(iOS)
import SwiftUI
import UIKit

struct InAppNotificationLayer: View {

    let delegate: InAppNotificationDelegte?
    @ObservedObject var queue: InAppNotificationQueue
    @ObservedObject var stateMachine = InAppNotificationStateMachine()

    init(queue: InAppNotificationQueue, delegate: InAppNotificationDelegte? = nil) {
        self.queue = queue
        self.delegate = delegate
    }

    var body: some View {
        GeometryReader { proxy in
            VStack {
                if let request = queue.current,
                   stateMachine.currentCanShowNotification {
                    VStack {
                        Spacer().frame(height: proxy.safeAreaInsets.top + 8)
                        request.view
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .shadow(radius: 6)
                            .onTapGesture {
                                self.stateMachine.transition(to: .hiding)
                                delegate?.notification(didTap: request)
                            }
                            .gesture(gesture(with: request))
                            .onAppear {
                                stateMachine.transition(to: .showing(duration: request.duration))
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
        .padding(.horizontal, 8)
    }

    private func gesture(with request: InAppNotificationRequest) -> some Gesture {
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
                    self.stateMachine.transition(to: .showing(duration: request.duration))
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
                                    Circle().foregroundColor(Color.dds.deerGreen)
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
#endif
