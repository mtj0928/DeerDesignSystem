import SwiftUI

struct PopupLayer: View {
    let popup: Popup?

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let popup = popup {
                    popup
                        .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}
