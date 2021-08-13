import SwiftUI
import DDS

struct TextAndButtonView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(DDSColor.primaryBackground.swiftUIColor)
                .ignoresSafeArea()
            ScrollView {
                HStack {
                    VStack(alignment: .leading, spacing: 12.0) {
                        Text("Primary Text Color: Deer / まつじ / 松本")
                            .preferredFont(for: .body)
                            .foregroundColor(DDSColor.primaryText.swiftUIColor)
                        Text("Secondary Text Color: Deer / まつじ / 松本")
                            .preferredFont(for: .body)
                            .foregroundColor(DDSColor.secondaryText.swiftUIColor)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(DDSColor.secondaryBackground.swiftUIColor)
                                .frame(height: 76)
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
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(16.0)
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

struct TextAndButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TextAndButtonView()
            .colorScheme(.light)
        TextAndButtonView()
            .colorScheme(.dark)
    }
}
