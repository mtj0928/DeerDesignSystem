import SwiftUI
import SFSafeSymbols

@available(iOS 14.0, *)
public struct SearchBar: View {

    let placeHolder: Text
    @Binding var input: String

    public init(placeHolder: Text, input: Binding<String>) {
        self.placeHolder = placeHolder
        self._input = input
    }

    public var body: some View {
        HStack {
            Image(systemSymbol: .magnifyingglass)
                .resizable()
                .scaledToFit()
                .foregroundColor(DDSColor.secondaryText.swiftUIColor)
                .padding(.vertical, 10)
            TextField("",
                text: $input,
                onEditingChanged: { editing in
                }, onCommit: {
                }
            )
            .placeholder(when: input.isEmpty) {
                placeHolder
                    .foregroundColor(DDSColor.secondaryText.swiftUIColor)
            }
            .textFieldStyle(PlainTextFieldStyle())
            .foregroundColor(DDSColor.primaryText.swiftUIColor)
            Spacer()
        }
        .padding(.horizontal, 12)
        .background(
            Capsule() .foregroundColor(DDSColor.secondaryBackground.swiftUIColor)
        )
        .frame(height: 40)
        .padding()
    }
}

struct SearchBar_Preview: PreviewProvider {

    static var previews: some View {
        ZStack {
//            DDSColor.primaryBackground.swiftUIColor
//                .ignoresSafeArea()
            VStack {
                BindingView(initialValue: "") { binding in
                    SearchBar(
                        placeHolder: Text("Type something"),
                        input: binding
                    )
                    .font(.footnote)
                }
                Spacer()
            }
        }

        ZStack {
//            DDSColor.primaryBackground.swiftUIColor
//                .ignoresSafeArea()
            VStack {
                BindingView(initialValue: "Hoge") { binding in
                    SearchBar(
                        placeHolder: Text("Type something"),
                        input: binding
                    )
                }
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}
