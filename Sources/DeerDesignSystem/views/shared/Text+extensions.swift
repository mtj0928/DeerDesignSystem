import SwiftUI

extension Text {

    public func preferredFont(for font: Font = .body, weight: Font.Weight = .regular) -> Text {
        self.font(font)
            .fontWeight(weight)
    }
}
