import SwiftUI
import DeerDesignSystem

struct RootView: View {

    #if os(iOS)

    static var windowScene: UIWindowScene? {
        UIApplication.shared.connectedScenes
            .sorted(by: { $0.activationState.rawValue > $1.activationState.rawValue })
            .compactMap { $0 as? UIWindowScene }
            .first
    }

    var inAppNotificationCenter: InAppNotificationCenter? {
        let cetner = Self.windowScene
            .flatMap(InAppNotificationCenter.resolve(for:))
        if cetner?.delegate == nil {
            cetner?.delegate = self
        }
        return cetner
    }

    var popupCenter: PopupCenter? {
        Self.windowScene.flatMap(PopupCenter.resolve(for:))
    }

    @State var text: String?
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
                        NavigationLink(
                            destination: PopupView(),
                            label: { Cell(text: "Popup") }
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
                .apply { view in
                    if let notificationCenter = inAppNotificationCenter {
                        view.environment(\.inAppNotificationQueue, notificationCenter.queue)
                            .environment(\.popupCenter, popupCenter)
                    } else {
                        view
                    }

                }
            }
            .sheet(isPresented: $isPresentingSheet) {
                Alignment {
                    (Text(text ?? "") + Text("がタップされました"))
                        .foregroundColor(Color.dds.primaryText)
                }.background(Color.dds.primaryBackground)
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
        let keyWindow = Self.windowScene?
            .windows
            .first(where: \.isKeyWindow)
        keyWindow?
            .rootViewController?
            .dismiss(animated: true, completion: {
                guard let request = request as? StandardInAppNotificationRequest else {
                    return
                }
                text = request.body
                isPresentingSheet = true
            })
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
