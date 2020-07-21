# Splash plugin for Publish

A [Publish](https://github.com/johnsundell/publish) plugin that makes it easy to integrate the [Splash](https://github.com/johnsundell/splash) Swift syntax highlighter into any Publish website.

## Installation

To install it into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "SplashPublishPlugin"
            ]
        )
    ]
    ...
)
```

Then import SplashPublishPlugin wherever you’d like to use it:

```swift
import SplashPublishPlugin
```

For more information on how to use the Swift Package Manager, check out [this article](https://www.swiftbysundell.com/articles/managing-dependencies-using-the-swift-package-manager), or [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

## Usage

The plugin can then be used within any publishing pipeline like this:

```swift
import SplashPublishPlugin
...
try DeliciousRecipes().publish(using: [
    .installPlugin(.splash(withClassPrefix: "classPrefix"))
    ...
])
```
