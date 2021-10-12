import SwiftUI

extension Color {
    public static var dds: DeerColor.Type { DeerColor.self }

    fileprivate static func asset(name: String) -> Color {
        Color(name, bundle: Bundle.currentModuel)
    }
}

public struct DeerColor {
    public static let buttonBackgroundDisabled = Color.asset(name: "button_background_disabled")
    public static let cellBackground = Color.asset(name: "cell_background")
    public static let cellBackgroundSelected = Color.asset(name: "cell_background_selected")
    public static let deerBlue = Color.asset(name: "deer_blue")
    public static let deerGreen = Color.asset(name: "deer_green")
    public static let deerGreenDark = Color.asset(name: "deer_green_dark")
    public static let deerRed = Color.asset(name: "deer_red")
    public static let modalBackground = Color.asset(name: "modal_background")
    public static let notificationBackground = Color.asset(name: "notification_background")
    public static let popupBackground = Color.asset(name: "popup_background")
    public static let primaryBackground = Color.asset(name: "primary_background")
    public static let primaryText = Color.asset(name: "primary_text")
    public static let secondaryBackground = Color.asset(name: "secondary_background")
    public static let secondaryText = Color.asset(name: "secondary_text")
    public static let tagText = Color.asset(name: "tag_text")
}


// MARK: - Workaround for module bug

public let imageBundle = Bundle.currentModuel
private class CurrentBundleFinder {}

extension Foundation.Bundle {

    static var currentModuel: Bundle = {
        let bundleName = "DeerDesignSystem_DeerDesignSystem"

        let bundleNameIOS = "LocalPackages_Database"
        let bundleNameMacOs = "DeerDesignSystem_DeerDesignSystem"

        let candidates = [
            Bundle.main.resourceURL,
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            Bundle.main.bundleURL,
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]


        for candidate in candidates {
            let bundlePathiOS = candidate?.appendingPathComponent(bundleNameIOS + ".bundle")
            let bundlePathMacOS = candidate?.appendingPathComponent(bundleNameMacOs + ".bundle")
            if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
                return bundle
            } else if let bundle = bundlePathMacOS.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named DeerDesignSystem_DeerDesignSystem")
    }()
}
