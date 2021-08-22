// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum DDSColor {
  public static let buttonBackgroundDisabled = ColorAsset(name: "button_background_disabled")
  public static let cellBackground = ColorAsset(name: "cell_background")
  public static let cellBackgroundSelected = ColorAsset(name: "cell_background_selected")
  public static let deerBlue = ColorAsset(name: "deer_blue")
  public static let deerGreen = ColorAsset(name: "deer_green")
  public static let deerGreenDark = ColorAsset(name: "deer_green_dark")
  public static let deerRed = ColorAsset(name: "deer_red")
  public static let modalBackground = ColorAsset(name: "modal_background")
  public static let notificationBackground = ColorAsset(name: "notification_background")
  public static let popupBackground = ColorAsset(name: "popup_background")
  public static let primaryBackground = ColorAsset(name: "primary_background")
  public static let primaryText = ColorAsset(name: "primary_text")
  public static let secondaryBackground = ColorAsset(name: "secondary_background")
  public static let secondaryText = ColorAsset(name: "secondary_text")
  public static let tagText = ColorAsset(name: "tag_text")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
