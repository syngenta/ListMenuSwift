// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "ListMenu",
    platforms: [.iOS(.v11)],
    products: [.library(name: "ListMenu", targets: ["ListMenu"])],
    targets: [.target(name: "ListMenu")],
    swiftLanguageVersions: [.v5]
)
