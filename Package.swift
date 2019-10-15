// swift-tools-version:5.0
//
// SwiftSpreadsheet
//

import PackageDescription

let package = Package(
    name: "SwiftSpreadsheet",
    products: [
        .library(
            name: "SwiftSpreadsheet",
            targets: ["SwiftSpreadsheet"]),
    ],
    targets: [
        .target(
            name: "SwiftSpreadsheet",
            dependencies: [],
            path: "SwiftSpreadsheet"),
    ],
   swiftLanguageVersions:[.v5]
)
