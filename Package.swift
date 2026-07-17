// swift-tools-version: 6.4

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "ExperimentKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .library(name: "ExperimentKit", targets: ["ExperimentKit"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftlang/swift-syntax.git",
            from: "604.0.0-latest"
        )
    ],
    targets: [
        .macro(
            name: "ExperimentKitMacros",
            dependencies: [
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                ),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(
            name: "ExperimentKit",
            dependencies: ["ExperimentKitMacros"]
        ),
        .testTarget(
            name: "ExperimentKitTests",
            dependencies: [
                "ExperimentKitMacros",
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                )
            ]
        )
    ]
)
