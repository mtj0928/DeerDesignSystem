import SwiftUI

public class InAppNotificationQueue: ObservableObject {

    @Published var current: InAppNotificationRequest?

    private var queue: [InAppNotificationRequest] = []

    public init() {}

    func next() {
        current = {
            guard !queue.isEmpty else { return nil }
            return queue.removeFirst()
        }()
    }

    public func add(_ request: InAppNotificationRequest) {
        if current == nil {
            current = request
        } else {
            queue.append(request)
        }
    }
}
