// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SLEssentials",
	platforms: [
		.iOS(.v11),
		.tvOS(.v15)
	],
	products: [
		.library(name: "SLEssentials", targets: ["SLEssentials", "iOS"]),
	],
	dependencies: [
		.package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1")),
		.package(url: "https://github.com/roberthein/TinyConstraints.git", .upToNextMajor(from: "4.0.2"))
	],
	targets: [
		.target(
			name: "SLEssentials",
			dependencies: ["Alamofire", "TinyConstraints"]
		),
		.target(
			name: "iOS",
			dependencies: ["SLEssentials"]
		)
	]
)
