// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BezierSwift",
  platforms: [
    .iOS(.v14),
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "BezierSwift",
      targets: ["BezierSwift"]),
  ],
  dependencies: [
    .package(url: "https://github.com/SDWebImage/SDWebImage.git", .upToNextMajor(from: "5.14.2")),
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "3.0.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "BezierSwift",
      dependencies: ["SDWebImage", "SDWebImageSwiftUI"]),
    .testTarget(
      name: "BezierSwiftTests",
      dependencies: ["BezierSwift"]),
  ],
  swiftLanguageVersions: [.v5]
)
