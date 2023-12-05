// swift-tools-version:5.9

import PackageDescription

let webAuthPlatforms: [Platform] = [
    .iOS,
    .visionOS,
    .macOS,
    .macCatalyst
]

let swiftSettings: [SwiftSetting] = [
    .define("WEB_AUTH_PLATFORM", .when(platforms: webAuthPlatforms))
]

let package = Package(
    name: "Auth0",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "Auth0", targets: ["Auth0"])
    ],
    dependencies: [
        .package(url: "https://github.com/svetrancicik/SimpleKeychain.git", branch: "simplekeychain-1-1-0"),
        .package(url: "https://github.com/svetrancicik/JWTDecode.swift.git", branch: "jwtdecode-3-1-0"),
        .package(url: "https://github.com/svetrancicik/Quick.git", branch: "quick-6-1-0"),
        .package(url: "https://github.com/svetrancicik/Nimble.git", branch: "nimble-12-3-0"),
        .package(url: "https://github.com/svetrancicik/OHHTTPStubs.git", branch: "ohttpstubs-9-1-0"),
    ],
    targets: [
        .target(
            name: "Auth0",
            dependencies: [
                .product(name: "SimpleKeychain", package: "SimpleKeychain"),
                .product(name: "JWTDecode", package: "JWTDecode.swift")
            ],
            path: "Auth0",
            exclude: ["Info.plist"],
            swiftSettings: swiftSettings),
        .testTarget(
            name: "Auth0Tests",
            dependencies: [
                "Auth0",
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
            ],
            path: "Auth0Tests",
            exclude: ["Info.plist", "Auth0.plist"],
            swiftSettings: swiftSettings)
    ]
)
