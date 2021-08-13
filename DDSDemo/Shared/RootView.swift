import SwiftUI
import DDS

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: TextAndButtonView(),
                    label: {
                        Text("Text and Button").dds.subheadline
                    }
                )
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
