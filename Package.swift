// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "gh-search",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "GHSearch", targets: [
            "GHSearch",
        ]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "0.0.4")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "0.4.1")),
        .package(url: "https://github.com/christopherweems/Resultto.git", .upToNextMajor(from: "0.1.1")),
        .package(url: "https://github.com/christopherweems/unstandard.git", .upToNextMajor(from: "0.1.6")),
        
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GHSearch",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Resultto", package: "Resultto"),
                .product(name: "unstandard", package: "unstandard"),
            ],
            resources: [
                .copy("KnownRepositories/GitHub.txt"),
            ]
        ),
        .executableTarget(
            name: "gh",
            dependencies: [
                "GHSearch",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "GHSearchTests",
            dependencies: ["GHSearch"]),
    ]
)
