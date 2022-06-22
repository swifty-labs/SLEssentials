// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SLEssentials",
	platforms: [
		.iOS(.v10),
		.tvOS(.v15)
	],
	products: [
		.library(name: "SLEssentials", targets: ["SLEssentials", "iOS"]),
	],
	targets: [
		.target(
			name: "SLEssentials"
		),
		.target(
			name: "iOS",
			dependencies: ["SLEssentials"]
		)
	]
)
