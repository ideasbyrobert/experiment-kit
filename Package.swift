// swift-tools-version: 5.9

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
            from: "602.0.0"
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
