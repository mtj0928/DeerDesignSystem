import SwiftUI
import DeerDesignSystem

struct ColorPalletView: View {

    let colors = [
        Color.dds.deerBlue,
        Color.dds.deerGreen,
        Color.dds.deerRed
    ]

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.dds.primaryBackground)
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

