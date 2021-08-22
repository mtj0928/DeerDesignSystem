import SwiftUI
import UIKit
import DDS

@available(iOS 14.0, *)
struct SampleSection: ListViewSection {

    let title: String
    let items: [SampleItem]

    typealias ReusableView = HeaderView

    class HeaderView: UICollectionReusableView, ListViewReusableView, HostingController {
        lazy var hostingController = UIHostingController(rootView: AnyView(body))
        weak var parentController: UIViewController?
        var contentView: UIView { self }

        var number: Int = 0 {
            didSet { refresh() }
        }

        var item: String? {
            didSet { refresh() }
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        var body: some View {
            Button(
                action: {
                    [weak self] in self?.number += 1
                },
                label: {
                    HStack {
                        (Text("\(number): ") + Text(item ?? ""))
                            .foregroundColor(DDSColor.primaryText.swiftUIColor)
                            .preferredFont(for: .title, weight: .heavy)
                        Spacer()
                    }
                }
            )
            .padding(.horizontal)
            .padding(.vertical, 8)
        }

        func apply(section: SampleSection) {
            self.item = section.title
        }
    }
}

@available(iOS 14.0, *)
struct SampleItem: ListItem {

    let image: Image
    let title: String
    let tappedAction: (Self) -> ()

    init(image: Image, title: String, tappedAction: @escaping (Self) -> ()) {
        self.image = image
        self.title = title
        self.tappedAction = tappedAction
    }

    static func == (lhs: SampleItem, rhs: SampleItem) -> Bool {
        lhs.image == rhs.image && lhs.title == rhs.title
    }

    func hash(into hasher: inout Hasher) {
        title.hash(into: &hasher)
    }

    func tapped() {
        self.tappedAction(self)
    }
}

@available(iOS 14.0, *)
class SampleCell: UICollectionViewListCell, ListViewCell, HostingController {

    lazy var hostingController = UIHostingController(rootView: AnyView(body))
    weak var parentController: UIViewController?

    var item: SampleItem?

    @ViewBuilder
    var body: some View {
        if let item = item {
            IconAndTitleItem.init(title: item.title) {
                ItemIcon(item.image)
                    .foregroundColor(.accentColor.opacity(0.2))
            }
            .padding()
            .foregroundColor(DDSColor.primaryText.swiftUIColor)
        }
    }

    override func updateConstraints() {
        super.updateConstraints()

        separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }

    func apply(item: SampleItem, at indexPath: IndexPath) {
        self.item = item
        refresh()
    }
}

@available(iOS 14.0, *)
struct SampleListView: View {
    @State var selected: String?
    @State var selectedItem: SampleItem? {
        didSet {
            selected = selectedItem?.title
        }
    }

    var body: some View {
        VStack(spacing: 0.0) {
            NavigationLink(destination: Text(selectedItem?.title ?? ""), tag: selectedItem?.title ?? "", selection: $selected) { EmptyView() }
            ListView<SampleSection, SampleCell>(sections: [
                SampleSection(
                    title: "About the app",
                    items: [
                        .init(image: .init(systemSymbol: .doc), title: "Privacy Policy") { selectedItem = $0 },
                        .init(image: .init(systemSymbol: .bubbleLeft), title: "Review") { selectedItem = $0 },
                    ]
                )
            ])
            .ignoresSafeArea()
        }
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(DDSColor.deerGreen.swiftUIColor)
        .background(DDSColor.primaryBackground.swiftUIColor)
    }
}
