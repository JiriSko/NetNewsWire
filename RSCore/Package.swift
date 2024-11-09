// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "RSCore",
	platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        .library(name: "RSCore", type: .dynamic, targets: ["RSCore"]),
		.library(name: "RSCoreObjC", type: .dynamic, targets: ["RSCoreObjC"]),
		.library(name: "RSCoreResources", type: .static, targets: ["RSCoreResources"])
    ],
	targets: [
		.target(
			name: "RSCore",
			dependencies: ["RSCoreObjC"],
			swiftSettings: [
				.unsafeFlags(["-warnings-as-errors"])
			]),
		.target(
			name: "RSCoreObjC",
			dependencies: [],
			cSettings: [
				.headerSearchPath("include")
			 ]
		),
		.target(
            name: "RSCoreResources",
            resources: [
                .process("Resources/WebViewWindow.xib"),
                .process("Resources/IndeterminateProgressWindow.xib")
            ]),
        .testTarget(
            name: "RSCoreTests",
            dependencies: ["RSCore"]),
    ]
)
