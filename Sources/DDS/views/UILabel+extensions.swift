#if os(iOS)
import UIKit

extension UILabel {

    public enum DDSLabel {
        public static func create(for textStyle: UIFont.TextStyle = .footnote, weight: UIFont.Weight = .regular) -> UILabel {
            let label = UILabel()
            label.font = UIFont.preferredFont(for: textStyle, weight: weight)
            label.adjustsFontForContentSizeCategory = true
            label.textColor = DDSColor.primaryText.color
            return label
        }
    }

    public static var dds: DDSLabel.Type {
        DDSLabel.self
    }
}

extension UIFont {
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: descriptor.pointSize, weight: weight)
        return UIFontMetrics(forTextStyle: style).scaledFont(for: font)
    }
}
#endif
