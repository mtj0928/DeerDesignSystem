#if os(iOS)
import SwiftUI

extension View {
    public func popupTransition() -> some View {
        self.transition(.scale(scale: 0.25)
                            .combined(with: .opacity)
                            .animation(.interactiveSpring())
        )
    }
}
#endif
