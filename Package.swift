// swift-tools-version:5.5

/**
*  Splash-plugin for Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "SplashPublishPlugin",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "SplashPublishPlugin",
            targets: ["SplashPublishPlugin"]
        )
    ],
    dependencies: [
        .package(
            name: "Publish",
            url: "https://github.com/johnsundell/publish.git",
            branch: "swift-concurrency"
        ),
        .package(
            name: "Splash",
            url: "https://github.com/johnsundell/splash.git",
            from: "0.12.0"
        )
    ],
    targets: [
        .target(
            name: "SplashPublishPlugin",
            dependencies: ["Splash", "Publish"]
        ),
        .testTarget(
            name: "SplashPublishPluginTests",
            dependencies: ["SplashPublishPlugin"]
        ),
    ]
)
