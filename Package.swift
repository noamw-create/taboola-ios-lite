// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "TaboolaLite",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "TaboolaLite", targets: ["TaboolaLite"]),
    ],
    targets: [
        .binaryTarget(
            name: "TaboolaLite",
            path: "TaboolaLite.xcframework"
        ),
    ]
)
