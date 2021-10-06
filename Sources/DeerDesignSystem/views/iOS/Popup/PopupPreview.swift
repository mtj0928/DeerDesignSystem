#if os(iOS)
import SwiftUI

public struct PopupPreview<Content: View>: View {

    @ObservedObject var center = PopupPreviewCenter.shared

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack {
            content().environment(\.popupCenter, center)
            PopupLayer(popup: center.popup)
        }
    }
}

struct PopupPreview_Previews: PreviewProvider {

    struct Content: View {
        @Environment(\.popupCenter) var popupCenter: PopupCenter?

        var body: some View {
            Button("show popup") {
                popupCenter?.popup = Popup(content: {
                    VStack {
                        Text("Hoge!").bold()
                        Spacer()
                        Button("close") {
                            popupCenter?.popup = nil
                        }
                        .transition(.move(edge: .bottom).animation(.easeOut))
                    }
                    .padding()
                    .frame(width: 300, height: 300)
                    .background(Color.white)
                    .cornerRadius(20)
                    .popupTransition()
                })
            }
        }
    }

    static var previews: some View {
        PopupPreview {
            Content()
        }
    }
}
#endif
