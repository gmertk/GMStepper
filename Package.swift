// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GMStepper",
    products: [
        .library(
            name: "GMStepper",
            targets: ["GMStepper"]
        ),
    ],
    targets: [
        .target(
            name: "GMStepper",
            dependencies: [],
            path: "GMStepper"
        ),
    ]
)
