import SwiftUI

extension Text {

    public struct DDSText {
        fileprivate let text: Text

        public var headline: Text {
            text.font(.system(size: 18.0))
                .bold()
                .foregroundColor(DDSColor.primaryText.swiftUIColor)
        }
        public var subheadline: Text {
            text.font(.system(size: 16.0))
                .bold()
                .foregroundColor(DDSColor.primaryText.swiftUIColor)
        }
        public var body: Text {
            text.font(.system(size: 14.0))
                .foregroundColor(DDSColor.primaryText.swiftUIColor)
        }
    }

    public var dds: DDSText {
        DDSText(text: self)
    }
}
