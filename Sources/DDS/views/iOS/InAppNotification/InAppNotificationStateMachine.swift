import SwiftUI

class InAppNotificationStateMachine: ObservableObject {

    enum InAppNotificationState: Equatable {
        case standby, showing(duration: TimeInterval?), dragging, hiding
    }

    @Published private(set) var currentState: InAppNotificationState = .standby
    @Published var offset: CGFloat = .zero

    var currentCanShowNotification: Bool { currentState != .hiding }
    private var timer: Timer?

    func transition(to nextState: InAppNotificationState) {
        switch (currentState, nextState) {
        case (.standby, .showing(let duration)),
             (.dragging, .showing(let duration)):
            offset = .zero
            currentState = nextState
            if let duration = duration {
                timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
                    DispatchQueue.main.async {
                        self?.transition(to: .hiding)
                    }
                }
            }
        case (.showing, .hiding),
             (.dragging, .hiding):
            currentState = .hiding
            offset = .zero
            timer?.invalidate()
        case (.hiding, .standby):
            currentState = .standby
            offset = .zero
        case (.showing, .dragging):
            timer?.invalidate()
            self.currentState = .dragging
        case (.dragging, .dragging):
            break
        default:
            // Error: reset
            self.currentState = .hiding
            self.offset = .zero
        }
    }
}
