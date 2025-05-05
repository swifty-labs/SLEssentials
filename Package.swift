// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SLEssentials",
	platforms: [
		.iOS(.v13),
		.tvOS(.v15)
	],
	products: [
		.library(
			name: "SLEssentials",
			targets: ["SLEssentials"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/ashleymills/Reachability.swift.git", .upToNextMajor(from: "5.1.0")),
		.package(url: "https://github.com/roberthein/TinyConstraints.git", .upToNextMajor(from: "4.0.2"))
	],
	targets: [
		.target(
			name: "SLEssentials",
			dependencies: [
				.product(name: "Reachability", package: "Reachability.swift"),
				.product(name: "TinyConstraints", package: "TinyConstraints")
			],
			path: "Sources"
		)
	]
)
