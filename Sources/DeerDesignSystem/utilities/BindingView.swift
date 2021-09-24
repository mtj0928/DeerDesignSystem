import SwiftUI

public struct BindingView<T, V: View>: View {
    @State var bindingValue: T
    let builder: (Binding<T>) -> V

    public init(
        initialValue: T,
        @ViewBuilder builder: @escaping (Binding<T>) -> V
    ) {
        self._bindingValue = State(initialValue: initialValue)
        self.builder = builder
    }

    public var body: some View {
        builder($bindingValue)
    }
}
