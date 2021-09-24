import SwiftUI

public struct BottomFullFillButton<Label: View>: View {

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

extension BottomFullFillButton where Label == Text {
    public init(text: String, action: @escaping () -> ()) {
        self.init(
            action: action,
            label: {
                Text(text)
                    .preferredFont(for: .headline, weight: .semibold)
                    .foregroundColor(.white)
            })
    }
}

struct BottomFullFillButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Spacer()
                    BottomFullFillButton(action: {}) {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 70, height: 70)
                    }
                    BottomFullFillButton(text: "XXX\nYYY\nZZZ") {}
                        .foregroundColor(.red)
                    BottomFullFillButton(text: "Button") {}
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
            }
        }
    }
}
