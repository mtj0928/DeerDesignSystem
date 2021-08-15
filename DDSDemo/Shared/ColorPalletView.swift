import SwiftUI
import DDS

struct ColorPalletView: View {

    let colors = [
        DDSColor.deerBlue,
        DDSColor.deerGreen,
        DDSColor.deerRed
    ].map(\.swiftUIColor)

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(DDSColor.primaryBackground.swiftUIColor)
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: .zero, maximum: .infinity)),
                    GridItem(.flexible(minimum: .zero, maximum: .infinity)),
                    GridItem(.flexible(minimum: .zero, maximum: .infinity))
                ]) {
                    ForEach(0..<colors.count) { index in
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(colors[index])
                                .frame(width: 75, height: 75)
                            Spacer()
                        }
                    }
                }
                .padding(.vertical)
            }
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

struct ColorPalletView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

