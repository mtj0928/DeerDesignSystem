import SwiftUI

public struct Alignment<Label: View>: View {

    let vertical: VerticalAlignment
    let horizon: HorizontalAlignment
    let label: () -> Label

    public init(
        _ vertical: VerticalAlignment = .center,
        _ horizon: HorizontalAlignment = .center,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.horizon = horizon
        self.vertical = vertical
        self.label = label
    }

    public var body: some View {
        HStack(spacing: 0) {
            if horizon == .leading {
                verticalView
            } else {
                Spacer(minLength: 0)
            }

            if horizon == .center {
                verticalView
            } else {
                Spacer(minLength: 0)
            }

            if horizon == .trailing {
                verticalView
            } else {
                Spacer(minLength: 0)
            }
        }
    }

    var verticalView: some View {
        VStack(spacing: 0) {
            if vertical == .top {
                label()
            } else {
                Spacer(minLength: 0)
            }

            if vertical == .center {
                label()
            } else {
                Spacer(minLength: 0)
            }

            if vertical == .bottom {
                label()
            } else {
                Spacer(minLength: 0)
            }
        }
    }
}
