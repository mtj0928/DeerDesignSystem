import SwiftUI
import SFSafeSymbols

public struct Tips<Title: View, Label: View>: View {

    public let title: () -> Title
    public let label: () -> Label
    public let closeAction: () -> Void

    public init(
        @ViewBuilder title: @escaping () -> Title,
        @ViewBuilder label: @escaping () -> Label,
        closeAction: @escaping () -> Void
    ) {
        self.title = title
        self.label = label
        self.closeAction = closeAction
    }

    public var body: some View {
        ZStack {
            HStack(spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    title().padding(.bottom, 4)
                    label()
                        .lineLimit(2)
                    Spacer()
                }
                Spacer(minLength: 0)
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)

            HStack {
                Spacer()
                VStack {
                    Button {
                        closeAction()
                    } label: {
                        Image(systemSymbol: .xmarkCircleFill)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
            .padding(8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
        )
    }
}

extension Tips where Title == Text, Label == Text {

    public init(title: String, body: String, closeAction: @escaping () -> Void) {
        self.init(
            title: {
                Text(title)
                    .preferredFont(for: .body, weight: .semibold)
                    .foregroundColor(.white)
            },
            label: {
                Text(body)
                    .preferredFont()
                    .foregroundColor(.white)
            },
            closeAction: closeAction
        )
    }
}

struct Tips_Preview: PreviewProvider {

    static var previews: some View {
        Group {
            VStack {
                Tips(
                    title: "Title",
                    body: "This is a body of the view.\nこれはViewの本文です"
                ) {
                    print("Closesd")
                }
                .frame(width: 347, height: 83)
                .foregroundColor(DDSColor.deerBlue.swiftUIColor)

                Tips(title: {
                    Text("Hoge")
                        .preferredFont(for: .body, weight: .heavy)
                        .foregroundColor(DDSColor.primaryText.swiftUIColor)
                }, label: {
                    HStack {
                        Circle().foregroundColor(DDSColor.deerGreen.swiftUIColor)
                            .frame(width: 10, height: 10)
                        Text("Custom")
                            .preferredFont(for: .footnote, weight: .medium)
                            .foregroundColor(DDSColor.deerRed.swiftUIColor)
                        Spacer()
                    }
                }, closeAction: {

                })
                .frame(width: 347, height: 83)
                .foregroundColor(DDSColor.secondaryBackground.swiftUIColor)

                Tips(
                    title: "Error",
                    body: "Failed to send a message"
                ) {
                }
                .frame(width: 347, height: 83)
                .foregroundColor(DDSColor.deerRed.swiftUIColor)
            }

            VStack {
                Tips(
                    title: "Title",
                    body: "This is a body of the view.\nこれはViewの本文です"
                ) {
                }
                .frame(width: 347, height: 83)
                .foregroundColor(DDSColor.deerBlue.swiftUIColor)

                Tips(
                    title: "Title",
                    body: "This is a body of the view.\nこれはViewの本文です"
                ) {
                }
                .frame(width: 347, height: 83)
                .foregroundColor(DDSColor.secondaryBackground.swiftUIColor)

                Tips(
                    title: "Error",
                    body: "Failed to send a message"
                ) {
                }
                .frame(width: 347, height: 83)
                .foregroundColor(DDSColor.deerRed.swiftUIColor)
            }
            .preferredColorScheme(.dark)
        }
    }
}
