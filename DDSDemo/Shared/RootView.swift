import SwiftUI
import DDS

struct RootView: View {

    #if os(iOS)
    let queue = InAppNotificationQueue()
    @State var text: String?
    @State var pushKind: String?
    @State var isPresentingSheet = false
    #endif

    private struct Cell: View {
        let text: String

        var body: some View {
            Text(text)
                .apply { view in
                    #if os(macOS)
                    view.preferredFont(for: .subheadline)
                    #else
                    view.preferredFont(for: .headline   , weight: .bold)
                        .padding(.vertical)
                    #endif
                }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: Alignment {
                        (Text("The body is ") + Text(text ?? ""))
                            .foregroundColor(DDSColor.primaryText.swiftUIColor)
                    }
                    .background(DDSColor.primaryBackground.swiftUIColor),
                    tag: "test",
                    selection: $pushKind,
                    label: { EmptyView() }
                )
                List {
                    NavigationLink(
                        destination: ColorPalletView(),
                        label: { Cell(text: "Color Pallet") }
                    )
                    NavigationLink(
                        destination: TextAndButtonView(),
                        label: { Cell(text: "Text and Button") }
                    )
                    if #available(iOS 14.0, *) {
                        NavigationLink(
                            destination: SampleListView(),
                            label: { Cell(text: "List") }
                        )
                        NavigationLink(
                            destination: SearchBarView(),
                            label: { Cell(text: "SearchBar") }
                        )
                    }
                }
            }
            .navigationTitle("DDS Demo")
            .apply { view in
                #if os(macOS)
                view
                #else
                view.listStyle(InsetGroupedListStyle())
                #endif
            }
            ColorPalletView()
        }
        .apply { view in
            #if os(iOS)
            ZStack {
                Group {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        view
                    } else {
                        view.navigationViewStyle(StackNavigationViewStyle())
                    }
                }
                .environment(\.inAppNotificationQueue, queue)
                .sheet(isPresented: $isPresentingSheet) {
                    Text("Hoge")
                }

                InAppNotificationLayer(queue: queue)
                    .environment(\.inAppNotificationDelegate, self)
            }
            #else
            view
            #endif
        }
    }
}

@available(iOS 14.0, *)
extension RootView: InAppNotificationDelegte {

    func notification(didTap request: InAppNotificationRequest) {
        isPresentingSheet = true
//        self.text = request.body ?? self.text
//        self.pushKind = "test"
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
