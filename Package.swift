// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "combine-plus",
    platforms: [
        .iOS(.v14),
        .macOS(.v13),
        .tvOS(.v13),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "CombinePlus",
            targets: ["CombinePlus"]
        ),
    ],
    targets: [
        .target(
            name: "CombinePlus"
        )
    ]
)
