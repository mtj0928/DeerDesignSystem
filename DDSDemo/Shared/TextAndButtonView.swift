import SwiftUI
import DDS

struct TextAndButtonView: View {

    @State var showTips = true
    @State var showAlert = false
    @State var selectedAlertButton = false

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(DDSColor.primaryBackground.swiftUIColor)
                .ignoresSafeArea()
            GeometryReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 12.0) {
                        Text("Primary Text Color: Deer / まつじ / 松本")
                            .preferredFont(for: .body)
                            .foregroundColor(DDSColor.primaryText.swiftUIColor)
                            .padding(.horizontal)

                        Text("Secondary Text Color: Deer / まつじ / 松本")
                            .preferredFont(for: .body)
                            .foregroundColor(DDSColor.secondaryText.swiftUIColor)
                            .padding(.horizontal)

                        HStack {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Secondary Background (primary)")
                                    .preferredFont(for: .body)
                                    .foregroundColor(DDSColor.primaryText.swiftUIColor)
                                Text("Secondary Background (secondary)")
                                    .preferredFont(for: .body)
                                    .foregroundColor(DDSColor.secondaryText.swiftUIColor)
                            }
                            Spacer()
                        }
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(DDSColor.secondaryBackground.swiftUIColor)
                        )
                        .padding(.horizontal)

                        if showTips {
                            Tips(
                                title: "Title",
                                body: "This is a body of the view.\nこれはViewの本文です",
                                tappedAction: { showAlert = true },
                                closeAction: {
                                    withAnimation {
                                        showTips = false
                                    }
                                }
                            )
                            .foregroundColor(DDSColor.deerBlue.swiftUIColor)
                            .padding(.horizontal)
                        }

                        Text("Tag")
                            .preferredFont(for: .footnote, weight: .bold)
                            .foregroundColor(DDSColor.primaryText.swiftUIColor)
                            .padding(.horizontal)

                        ScrollView(.horizontal) {
                            HStack {
                                Tag(title: Text("Tag"), action: { showAlert = true })
                                    .foregroundColor(DDSColor.deerBlue.swiftUIColor)
                                Tag(title: Text("XXXXXXXXX"), action: { showAlert = true })
                                    .foregroundColor(DDSColor.deerRed.swiftUIColor)
                                Tag(
                                    title: Text("Tag").foregroundColor(DDSColor.deerBlue.swiftUIColor),
                                    action: { showAlert = true }
                                ).foregroundColor(DDSColor.deerBlue.swiftUIColor.opacity(0.15))
                                Tag(
                                    title: Text(Image(systemSymbol: .plus)).foregroundColor(DDSColor.primaryText.swiftUIColor),
                                    shape: Circle(),
                                    action: { showAlert = true }
                                ).foregroundColor(DDSColor.secondaryBackground.swiftUIColor)
                            }
                            .padding(.horizontal)
                        }

                        CheckButton(title: "Don't show this alert again.", isSelected: $selectedAlertButton)
                            .padding()
                            .accentColor(DDSColor.deerGreen.swiftUIColor)

                        Spacer()

                        BottomFullFillButton(text: "Disabled Button") { showAlert = true }
                        .foregroundColor(DDSColor.deerBlue.swiftUIColor)
                        .padding(.horizontal)
                        .disabled(true)

                        BottomFullFillButton(text: "Button") { showAlert = true }
                        .foregroundColor(DDSColor.deerBlue.swiftUIColor)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    .padding(.top)
                    .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"))
                }
                .apply { view in
                    #if os(iOS)
                    view.navigationBarTitleDisplayMode(.inline)
                    #else
                    view
                    #endif
                }
            }
        }
    }
}

struct TextAndButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TextAndButtonView()
            .colorScheme(.light)
        TextAndButtonView()
            .colorScheme(.dark)
    }
}
