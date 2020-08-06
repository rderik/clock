// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "clock",
    dependencies: [
        .package(url: "https://github.com/rderik/SwiftCursesTerm.git", from: "0.1.2"),
    ],
    targets: [
        .target(
            name: "clock",
            dependencies: ["SwiftCursesTerm"]),
        .testTarget(
            name: "clockTests",
            dependencies: ["clock"]),
    ]
)
