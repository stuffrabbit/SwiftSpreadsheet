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
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftSpreadsheet",
            dependencies: [],
            path: "SwiftSpreadsheet"
        ),
    ],
   swiftLanguageVersions:[.v5]
)
