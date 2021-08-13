import SwiftUI

extension View {

    @ViewBuilder
    public func apply<V: View>(@ViewBuilder handler: (Self) -> V) -> some View {
        handler(self)
    }

    @ViewBuilder
    public func `if`<V: View>(_ condition: Bool, @ViewBuilder handler: (Self) -> V) -> some View {
        if condition {
            handler(self)
        } else {
            self
        }
    }
}
