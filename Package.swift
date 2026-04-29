// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RacketPointOverlayKit",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(name: "RacketPointOverlayKit", targets: ["RacketPointOverlayKit"])
    ],
    targets: [
        .target(
            name: "RacketPointOverlayKit",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "RacketPointOverlayKitTests",
            dependencies: ["RacketPointOverlayKit"]
        )
    ]
)
