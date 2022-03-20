// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "LinkSelectableTextView",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "LinkSelectableTextView",
            targets: ["LinkSelectableTextView"]),
    ],
    targets: [
        .target(
            name: "LinkSelectableTextView",
            dependencies: []),
    ]
)
