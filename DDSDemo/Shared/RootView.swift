import SwiftUI
import DDS

struct RootView: View {

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
            if UIDevice.current.userInterfaceIdiom == .pad {
                view
            } else {
                view.navigationViewStyle(StackNavigationViewStyle())
            }
            #else
            view
            #endif
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
