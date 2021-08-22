import SwiftUI
import DDS

struct SearchBarView: View {
    @State var text: String = ""

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                DDSColor.primaryBackground.swiftUIColor.ignoresSafeArea()
                ScrollView {
                    VStack {
                        SearchBar(
                            placeHolder: Text("Type something"),
                            input: $text
                        )
                        Spacer()
                    }
                    .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct SearchBarView_Provider: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
