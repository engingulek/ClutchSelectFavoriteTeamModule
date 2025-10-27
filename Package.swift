// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClutchSelectFavTeamModule",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ClutchSelectFavTeamModule",
            targets: ["ClutchSelectFavTeamModule"]),
    ],
    
    dependencies: [
           .package(url: "https://github.com/onevcat/Kingfisher", from: "8.5.0"),
           .package(url: "https://github.com/engingulek/ClutchCoreKit",branch: "master"),
           .package(url: "https://github.com/engingulek/ClutchModularProtocols",from: "0.0.3"),
           .package(url: "https://github.com/engingulek/ClutchManagerKits", branch: "develop"),
           .package(url: "https://github.com/engingulek/ClutchNavigationKit",branch: "develop"),
           
        
               
       ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ClutchSelectFavTeamModule",
            dependencies: [
                .product(name: "ClutchCoreKit", package: "ClutchCoreKit"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "ClutchModularProtocols", package: "ClutchModularProtocols"),
                .product(name: "ClutchManagerKits", package: "ClutchManagerKits"),
                .product(name: "ClutchNavigationKit", package: "ClutchNavigationKit")
            ]
        
        ),
        .testTarget(
            name: "ClutchSelectFavTeamModuleTests",
            dependencies: ["ClutchSelectFavTeamModule"]
        ),
    ]
)
