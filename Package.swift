// swift-tools-version:5.1

/**
*  Splash-plugin for Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "SplashPublishPlugin",
    products: [
        .library(
            name: "SplashPublishPlugin",
            targets: ["SplashPublishPlugin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.5.0"),
        .package(url: "https://github.com/johnsundell/splash.git", from: "0.12.0")
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
