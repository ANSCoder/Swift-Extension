// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftExtension",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "SwiftExtension", targets: ["SwiftExtension"])
    ],
    targets: [
        .target(
            name: "SwiftExtension",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny")
            ]
        ),
        .testTarget(
            name: "SwiftExtensionTests",
            dependencies: ["SwiftExtension"]
        )
    ],
    swiftLanguageModes: [.v6]
)
