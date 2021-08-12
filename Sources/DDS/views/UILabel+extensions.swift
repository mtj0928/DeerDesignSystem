#if os(iOS)
import UIKit

extension UILabel {

    public struct DDSLabel {
        func headline() -> UILabel {
            createLabel(size: 18.0, bold: true)
        }

        func subheadline() -> UILabel {
            createLabel(size: 16.0, bold: true)
        }

        func boby() -> UILabel {
            createLabel(size: 14.0, bold: false)
        }

        private func createLabel(size: CGFloat, bold: Bool) -> UILabel {
            let font: UIFont = bold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size)

            let label = UILabel()
            label.font = UIFontMetrics.default.scaledFont(for: font)
            label.adjustsFontForContentSizeCategory = true
            label.textColor = DDSColor.primaryText.color
            return label
        }
    }

    static var dds: DDSLabel {
        DDSLabel()
    }
}
#endif
