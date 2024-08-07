// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "ArticleExtractor",
	platforms: [.macOS(.v14), .iOS(.v17)],
	products: [
		.library(
			name: "ArticleExtractor",
			targets: ["ArticleExtractor"]),
	],
	dependencies: [
		.package(path: "../FoundationExtras"),
		.package(path: "../Secrets")
	],
	targets: [
		.target(
			name: "ArticleExtractor",
			dependencies: [
				"FoundationExtras",
				"Secrets"
			],
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency")
			]
		),
		.testTarget(
			name: "ArticleExtractorTests",
			dependencies: ["ArticleExtractor"]),
	]
)
