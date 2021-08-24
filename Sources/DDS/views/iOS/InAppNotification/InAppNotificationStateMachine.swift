import SwiftUI

class InAppNotificationStateMachine: ObservableObject {

    enum InAppNotificationState {
        case standby, showing, dragging, hiding
    }

    @Published private(set) var currentState: InAppNotificationState = .standby
    @Published var offset: CGFloat = .zero

    var currentCanShowNotification: Bool { currentState != .hiding }
    var timer: Timer?

    func transition(to nextState: InAppNotificationState) {
        switch (currentState, nextState) {
        case (.standby, .showing),
             (.dragging, .showing):
            offset = .zero
            currentState = .showing
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
                DispatchQueue.main.async {
                    self?.transition(to: .hiding)
                }
            }
        case (.showing, .hiding),
             (.dragging, .hiding):
            currentState =  .hiding
            offset = .zero
            timer?.invalidate()
        case (.hiding, .standby):
            currentState = .standby
            offset = .zero
        case (.showing, .dragging):
            timer?.invalidate()
            self.currentState = .dragging
        default: break
        }
    }
}
