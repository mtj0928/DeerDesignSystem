import SwiftUI
import SFSafeSymbols

public struct ItemIcon: View {
    let image: Image

    public init(_ image: Image) {
        self.image = image
    }

    public var body: some View {
        Text(image)
            .foregroundColor(.accentColor)
            .bold()
            .frame(width: 37, height: 37)
            .background(RoundedRectangle(cornerRadius: 8))
    }
}

public struct IconAndTitleItem<Icon: View, Title: View>: View {

    let icon: () -> Icon
    let title: () -> Title

    public init(
        @ViewBuilder icon: @escaping () -> Icon,
        @ViewBuilder title: @escaping () -> Title
    ) {
        self.icon = icon
        self.title = title
    }

    public var body: some View {
        HStack(spacing: .zero) {
            icon().padding(.trailing, 16)
            title()
            Spacer(minLength: .zero)
        }
    }
}

extension IconAndTitleItem where Title == Text {

    public init(
        title: String,
        @ViewBuilder icon: @escaping () -> Icon
    ) {
        self.init(
            icon: icon,
            title: {
                Text(title)
                    .preferredFont(for: .body, weight: .bold)
                    .foregroundColor(Color.dds.primaryText)
            }
        )
    }
}

struct IconAndTitleItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                List {
                    Section(header: Text("Section Header")
                                .foregroundColor(Color.dds.primaryText)
                                .preferredFont(for: .title, weight: .heavy)
                                .padding(.bottom, 4.0)
                    ) {
                        NavigationLink(destination: Text("Hello")) {
                            IconAndTitleItem(title: "Title") {
                                ItemIcon(.init(systemSymbol: .bubbleLeft))
                                    .foregroundColor(.accentColor.opacity(0.2))
                            }
                            .padding(.vertical, 8)

                        }
                        .listRowBackground(Color.dds.cellBackground)

                        NavigationLink(destination: Text("World")) {
                            IconAndTitleItem(title: "Title") {
                                ItemIcon(.init(systemSymbol: .doc))
                                    .foregroundColor(.green.opacity(0.2))
                                    .accentColor(.green)
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color.dds.cellBackground)
                    }
                    .textCase(nil)
                }
                .apply { view in
    #if os(iOS)
                    view.listStyle(GroupedListStyle())
    #else
                    view
    #endif
                }
            }

            NavigationView {
                List {
                    Section(header: Text("Section Header")
                                .foregroundColor(Color.dds.primaryText)
                                .preferredFont(for: .title, weight: .heavy)
                                .padding(.bottom, 4.0)
                    ) {
                        NavigationLink(destination: Text("Hello")) {
                            IconAndTitleItem(title: "Title") {
                                ItemIcon(.init(systemSymbol: .bubbleLeft))
                                    .foregroundColor(.accentColor.opacity(0.2))
                            }
                            .padding(.vertical, 8)

                        }
                        .listRowBackground(Color.dds.cellBackground)

                        NavigationLink(destination: Text("World")) {
                            IconAndTitleItem(title: "Title") {
                                ItemIcon(.init(systemSymbol: .doc))
                                    .foregroundColor(.green.opacity(0.2))
                                    .accentColor(.green)
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color.dds.cellBackground)
                    }
                    .textCase(nil)
                }
                .apply { view in
    #if os(iOS)
                    view.listStyle(GroupedListStyle())
    #else
                    view
    #endif
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
