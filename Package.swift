// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "measurement-reader",
  platforms: [
    .macOS(SupportedPlatform.MacOSVersion.v11),
    .iOS(SupportedPlatform.IOSVersion.v14),
  ],
  products: [
    .library(
      name: "MeasurementReader",
      targets: ["MeasurementReader"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0"),
  ],
  targets: [
    .target(
      name: "MeasurementReader",
      dependencies: []
    ),
    .testTarget(
      name: "MeasurementReaderTests",
      dependencies: [
        "MeasurementReader",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ],
      resources: [.process("__Snapshots__")]
    ),
  ]
)
