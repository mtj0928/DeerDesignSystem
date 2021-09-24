// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DeerDesignSystem",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "DeerDesignSystem",
            targets: ["DeerDesignSystem"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/piknotech/SFSafeSymbols.git", .upToNextMajor(from: "2.1.3"))
    ],
    targets: [
        .target(
            name: "DeerDesignSystem",
            dependencies: ["SFSafeSymbols"]),
        .testTarget(
            name: "DDSTests",
            dependencies: ["DeerDesignSystem"]),
    ]
)
