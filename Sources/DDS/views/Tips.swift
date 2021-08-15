import SwiftUI
import SFSafeSymbols

public struct Tips<Title: View, Label: View>: View {

    @State var isPressing = false

    public let title: () -> Title
    public let label: () -> Label
    public let tappedAction: (() -> Void)?
    public let closeAction: (() -> Void)?

    public init(
        @ViewBuilder title: @escaping () -> Title,
        @ViewBuilder label: @escaping () -> Label,
        tappedAction: (() -> Void)? = nil,
        closeAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.label = label
        self.tappedAction = tappedAction
        self.closeAction = closeAction
    }

    public var body: some View {
        ZStack {
            Button(action: {
                tappedAction?()
            }) {
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
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(RoundedRectangle(cornerRadius: 12))

                    if let closeAction = closeAction {
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemSymbol: .xmarkCircleFill)
                                    .foregroundColor(.white)
                                    .opacity(isPressing ? 0.5 : 1.0)
                                    .gesture(
                                        DragGesture(minimumDistance: .zero)
                                            .onChanged { value in
                                                let distance = value.location.distance(with: value.startLocation)
                                                isPressing = distance < 100
                                            }
                                            .onEnded { value in
                                                isPressing = false
                                                let distance = value.location.distance(with: value.startLocation)
                                                if distance < 100 {
                                                    closeAction()
                                                }
                                            }
                                    )
                                    .frame(width: 25)
                                    .aspectRatio(1.0, contentMode: .fill)
                                Spacer()
                            }
                        }
                        .padding(8)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

extension Tips where Title == Text, Label == Text {

    public init(title: String, body: String, tappedAction: (() -> Void)? = nil, closeAction: (() -> Void)? = nil) {
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
            tappedAction: tappedAction,
            closeAction: closeAction
        )
    }
}

struct Tips_Preview: PreviewProvider {

    static var previews: some View {
        Group {
            ScrollView {
                Tips(
                    title: "Title",
                    body: "This is a body of the view.\nこれはViewの本文です"
                ).foregroundColor(DDSColor.deerBlue.swiftUIColor)

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
                }).foregroundColor(DDSColor.secondaryBackground.swiftUIColor)

                Tips(
                    title: "Error",
                    body: "Failed to send a message"
                ).foregroundColor(DDSColor.deerRed.swiftUIColor)
            }
            .padding()
            .preferredColorScheme(.light)

            ScrollView {
                Tips(
                    title: "Title",
                    body: "This is a body of the view.\nこれはViewの本文です"
                ).foregroundColor(DDSColor.deerBlue.swiftUIColor)

                Tips(
                    title: "Title",
                    body: "This is a body of the view.\nこれはViewの本文です"
                ).foregroundColor(DDSColor.secondaryBackground.swiftUIColor)

                Tips(
                    title: "Error",
                    body: "Failed to send a message"
                ).foregroundColor(DDSColor.deerRed.swiftUIColor)
            }
            .padding()
            .preferredColorScheme(.dark)
        }
    }
}