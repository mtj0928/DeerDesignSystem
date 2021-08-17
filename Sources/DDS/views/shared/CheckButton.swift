import SwiftUI
import SFSafeSymbols

public struct CheckButton<Title: View, Icon: View>: View {

    @Binding var isSelected: Bool

    let title: () -> Title
    let icon: (Bool) -> Icon

    public init(
        title: @escaping () -> Title,
        isSelected: Binding<Bool>,
        @ViewBuilder icon: @escaping (Bool) -> Icon
    ) {
        self.title = title
        self._isSelected = isSelected
        self.icon = icon
    }

    public var body: some View {
        Button(
            action: { isSelected.toggle() },
            label: {
                HStack(alignment: .center, spacing: 5) {
                    icon(isSelected)
                    title()
                }
            }
        )
        .buttonStyle(PlainButtonStyle())
    }
}

extension CheckButton where Title == Text, Icon == Text {
    public init(title: String, isSelected: Binding<Bool>) {
        self.init(
            title: {
                Text(title)
                    .preferredFont(for: .body, weight: .regular)
            },
            isSelected: isSelected,
            icon: { isSelected in
                if isSelected {
                    return Text(Image(systemSymbol: .checkmarkCircleFill))
                        .preferredFont(for: .body, weight: .bold)
                        .foregroundColor(.accentColor)
                } else {
                    return Text(Image(systemSymbol: .checkmarkCircle))
                        .preferredFont(for: .body, weight: .bold)
                }
            }
        )
    }
}

struct CheckButton_Previews: PreviewProvider {

    static var previews: some View {
        ScrollView {
            HStack {
                VStack {
                    BindingView(initialValue: true) { selected in
                        CheckButton(title: "Don't show this alert again", isSelected: selected)
                            .accentColor(.green)
                    }
                    Spacer()
                    CheckButton(title: "Don't show this alert again", isSelected: .constant(false))
                }
                Spacer()
            }
            .padding()
        }
    }
}
