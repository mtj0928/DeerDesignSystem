import SwiftUI

extension View {

    @ViewBuilder
    public func `if`<V: View>(_ condition: Bool, @ViewBuilder handler: (Self) -> V) -> some View {
        if condition {
            handler(self)
        } else {
            self
        }
    }
}
