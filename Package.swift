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
	dependencies: [
		.package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1"))
	],
	targets: [
		.target(
			name: "SLEssentials",
			dependencies: ["Alamofire"]
		),
		.target(
			name: "iOS",
			dependencies: ["SLEssentials"]
		)
	]
)
