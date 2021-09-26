#if os(iOS)
import SwiftUI

public struct Popup: View {
    let content: () -> AnyView
    let background: () -> AnyView

    public init<Content: View, Background: View>(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder background: @escaping () -> Background
    ) {
        self.content = { AnyView(content()) }
        self.background = { AnyView(background()) }
    }

    public init<Content: View>(@ViewBuilder content: @escaping () -> Content) {
        self.content = { AnyView(content()) }
        self.background = {
            AnyView(
                Color.black
                    .opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity.animation(.interactiveSpring()))
            )
        }
    }

    @ViewBuilder
    public var body: some View {
        background()
            .zIndex(0)
        content()
            .zIndex(1)
    }
}
#endif
