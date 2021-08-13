import SwiftUI

extension Text {

    public func preferredFont(for font: Font = .footnote, weight: Font.Weight = .regular) -> Text {
        self.font(font)
            .fontWeight(weight)
    }
}
