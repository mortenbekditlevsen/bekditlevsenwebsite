// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "bekditlevsen",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "uberdoodle", targets: ["uberdoodle"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/shellout.git", from: "2.3.0"),
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.9.0"),
        .package(url: "https://github.com/johnsundell/splashpublishplugin", from: "0.2.0")
    ],
    targets: [
        .executableTarget(
            name: "uberdoodle",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                .product(name: "SplashPublishPlugin", package: "splashpublishplugin"),
                .product(name: "ShellOut", package: "shellout")
            ]
        )
    ]
)
