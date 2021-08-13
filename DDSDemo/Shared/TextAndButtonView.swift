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
                            .dds
                            .body
                        Text("Secondary Text Color: Deer / まつじ / 松本")
                            .foregroundColor(DDSColor.secondaryText.swiftUIColor)
                            .dds
                            .body
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(DDSColor.secondaryBackground.swiftUIColor)
                                .frame(height: 76)
                            HStack {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Secondary Background (primary)")
                                        .dds
                                        .body
                                    Text("Secondary Background (secondary)")
                                        .foregroundColor(DDSColor.secondaryText.swiftUIColor)
                                        .dds
                                        .body

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
