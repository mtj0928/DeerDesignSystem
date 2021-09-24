import SwiftUI
import SFSafeSymbols

@available(iOS 14.0, *)
public struct SearchBar: View {

    let placeHolder: Text
    @Binding var input: String
    let commitHandler: () -> Void

    public init(placeHolder: Text, input: Binding<String>, onCommit commitHandler: @escaping () -> Void = {}) {
        self.placeHolder = placeHolder
        self._input = input
        self.commitHandler = commitHandler
    }

    public var body: some View {
        HStack {
            Image(systemSymbol: .magnifyingglass)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.dds.secondaryText)
                .padding(.vertical, 10)
            TextField("",
                text: $input,
                onEditingChanged: { _ in },
                onCommit: commitHandler
            )
            .placeholder(when: input.isEmpty) {
                placeHolder
                    .foregroundColor(Color.dds.secondaryText)
            }
            .textFieldStyle(PlainTextFieldStyle())
            .foregroundColor(Color.dds.primaryText)
            Spacer()
        }
        .padding(.horizontal, 12)
        .background(
            Capsule() .foregroundColor(Color.dds.secondaryBackground)
        )
        .frame(height: 40)
        .padding()
    }
}

struct SearchBar_Preview: PreviewProvider {

    static var previews: some View {
        ZStack {
//            Color.dds.primaryBackground
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
//            Color.dds.primaryBackground
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
