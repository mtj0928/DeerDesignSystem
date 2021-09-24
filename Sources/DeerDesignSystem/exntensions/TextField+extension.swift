import SwiftUI

extension TextField {

    public func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: SwiftUI.Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}
