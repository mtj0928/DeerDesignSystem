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
                .foregroundColor(Color.dds.tagText)
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
                    Tag(title: Text("Hoge").foregroundColor(Color.dds.tagText)) {
                    }
                    .foregroundColor(.blue)

                    Tag(
                        title: Text("XXXXXXXXXXXXXXXXXXXX")
                            .foregroundColor(Color.dds.deerBlue),
                        action: {}
                    )
                        .foregroundColor(Color.dds.deerBlue.opacity(0.15))

                    Tag(
                        title: Text(Image(systemSymbol: .plus))
                            .foregroundColor(Color.dds.tagText)
                            .preferredFont(for: .headline, weight: .heavy),
                        shape: Circle(),
                        action: {}
                    )
                        .foregroundColor(Color.dds.secondaryBackground)
                }
            }
        }
    }
}
