// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuickActionsKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "QuickActionsKit",
            targets: ["QuickActionsKit"]
        )
    ],
    targets: [
        .target(
            name: "QuickActionsKit"
        )
    ]
)
