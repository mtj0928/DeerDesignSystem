import SwiftUI
import DeerDesignSystem

struct TextAndButtonView: View {

    @State var showTips = true
    @State var showAlert = false
    @State var selectedAlertButton = false

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.dds.primaryBackground)
                .ignoresSafeArea()
            GeometryReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 12.0) {
                        Text("Primary Text Color: Deer / まつじ / 松本")
                            .preferredFont(for: .body)
                            .foregroundColor(Color.dds.primaryText)
                            .padding(.horizontal)

                        Text("Secondary Text Color: Deer / まつじ / 松本")
                            .preferredFont(for: .body)
                            .foregroundColor(Color.dds.secondaryText)
                            .padding(.horizontal)

                        HStack {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Secondary Background (primary)")
                                    .preferredFont(for: .body)
                                    .foregroundColor(Color.dds.primaryText)
                                Text("Secondary Background (secondary)")
                                    .preferredFont(for: .body)
                                    .foregroundColor(Color.dds.secondaryText)
                            }
                            Spacer()
                        }
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(Color.dds.secondaryBackground)
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
                            .foregroundColor(Color.dds.deerBlue)
                            .padding(.horizontal)
                        }

                        Text("Tag")
                            .preferredFont(for: .footnote, weight: .bold)
                            .foregroundColor(Color.dds.primaryText)
                            .padding(.horizontal)

                        ScrollView(.horizontal) {
                            HStack {
                                Tag(title: Text("Tag"), action: { showAlert = true })
                                    .foregroundColor(Color.dds.deerBlue)
                                Tag(title: Text("XXXXXXXXX"), action: { showAlert = true })
                                    .foregroundColor(Color.dds.deerRed)
                                Tag(
                                    title: Text("Tag").foregroundColor(Color.dds.deerBlue),
                                    action: { showAlert = true }
                                ).foregroundColor(Color.dds.deerBlue.opacity(0.15))
                                Tag(
                                    title: Text(Image(systemSymbol: .plus)).foregroundColor(Color.dds.primaryText),
                                    shape: Circle(),
                                    action: { showAlert = true }
                                ).foregroundColor(Color.dds.secondaryBackground)
                            }
                            .padding(.horizontal)
                        }

                        CheckButton(title: "Don't show this alert again.", isSelected: $selectedAlertButton)
                            .padding()
                            .accentColor(Color.dds.deerGreen)

                        Spacer()

                        FullFillButton(text: "Disabled Button") { showAlert = true }
                        .foregroundColor(Color.dds.deerBlue)
                        .padding(.horizontal)
                        .disabled(true)

                        FullFillButton(text: "Button") { showAlert = true }
                        .foregroundColor(Color.dds.deerBlue)
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
