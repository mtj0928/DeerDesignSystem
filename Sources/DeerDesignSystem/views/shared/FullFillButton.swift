import SwiftUI

public struct FullFillButton<Label: View>: View {

    let action: () -> ()
    let label: () -> Label

    public init(
        action: @escaping () -> (),
        label: @escaping () -> Label
    ) {
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(
            action: { action() },
            label: {
                HStack {
                    Spacer()
                    label()
                        .apply(handler: { view in
                            #if os(watchOS)
                            view.padding(12)
                            #else
                            view.padding()
                            #endif
                        })
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 10))
                .frame(minHeight: 50)
            }
        )
        .buttonStyle(PlainButtonStyle())
    }
}

extension FullFillButton where Label == Text {
    public init(text: String, action: @escaping () -> ()) {
        self.init(
            action: action,
            label: {
                Text(text)
                    .preferredFont(for: .headline, weight: .semibold)
                    .foregroundColor(.white)
            }
        )
    }
}

struct FullFillButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Spacer()
                    FullFillButton(action: {}) {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 70, height: 70)
                    }
                    FullFillButton(text: "XXX\nYYY\nZZZ") {}
                        .foregroundColor(.red)
                    FullFillButton(text: "Button") {}
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
            }
        }
    }
}
