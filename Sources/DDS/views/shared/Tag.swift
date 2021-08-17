import SwiftUI

public struct Tag<BackgrounShape: Shape>: View {
    let title: Text
    let action: () -> Void
    let backgroundShape: BackgrounShape

    public init(title: Text, action: @escaping () -> Void) where BackgrounShape == Capsule {
        self.title = title
        self.action = action
        self.backgroundShape = Capsule()
    }

    public init(title: Text, shape: BackgrounShape, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.backgroundShape = shape
    }

    public var body: some View {
        Button(action: action) {
            title
                .preferredFont(for: .footnote, weight: .medium)
                .padding(.horizontal)
                .padding(.vertical, 8.0)
                .foregroundColor(DDSColor.tagText.swiftUIColor)
                .background(backgroundShape)
        }
        .apply { view in
            #if os(macOS) || os(watchOS)
            view.buttonStyle(PlainButtonStyle())
            #else
            view
            #endif
        }
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HStack {
                VStack(spacing: 16.0) {
                    Tag(title: Text("Hoge").foregroundColor(DDSColor.tagText.swiftUIColor)) {
                    }
                    .foregroundColor(.blue)

                    Tag(
                        title: Text("XXXXXXXXXXXXXXXXXXXX")
                            .foregroundColor(DDSColor.deerBlue.swiftUIColor),
                        action: {}
                    )
                        .foregroundColor(DDSColor.deerBlue.swiftUIColor.opacity(0.15))

                    Tag(
                        title: Text(Image(systemSymbol: .plus))
                            .foregroundColor(DDSColor.tagText.swiftUIColor)
                            .preferredFont(for: .headline, weight: .heavy),
                        shape: Circle(),
                        action: {}
                    )
                        .foregroundColor(DDSColor.secondaryBackground.swiftUIColor)
                }
            }
        }
    }
}
