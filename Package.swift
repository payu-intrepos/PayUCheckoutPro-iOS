// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PayUCheckoutProKit",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PayUIndia-CheckoutProBase",
            targets: ["PayUIndia-CheckoutProBaseTarget"]),
        .library(
            name: "PayUIndia-CheckoutPro",
            targets: ["PayUIndia-CheckoutProTarget"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "PayUIndia-PayUParams",url: "https://github.com/payu-intrepos/payu-params-iOS.git", from: "3.3.0"),
        .package(name: "PayUIndia-NetworkReachability",url: "https://github.com/payu-intrepos/PayUNetworkReachability-iOS.git", from: "2.0.1"),
        .package(name: "PayUIndia-Analytics",url: "https://github.com/payu-intrepos/PayUAnalytics-iOS.git", from: "2.1.1"),
        .package(name: "PayUIndia-CrashReporter",url: "https://github.com/payu-intrepos/PayUCrashReporter-iOS.git", from: "2.0.1"),
        .package(name: "PayUIndia-AssetLibrary",url: "https://github.com/payu-intrepos/PayUAssetLibrary-iOS.git", from: "3.1.1"),
        .package(name: "PayUIndia-PG-SDK",url: "https://github.com/payu-intrepos/iOS-SDK.git", from: "8.2.0"),
        .package(name: "PayUIndia-Custom-Browser",url: "https://github.com/payu-intrepos/iOS-Custom-Browser.git", from: "9.0.1"),
        .package(name: "PayUIndia-NativeOtpAssist",url: "https://github.com/payu-intrepos/PayUNativeOtpAssist-iOS.git", from: "2.1.1"),
        .package(name: "PayUIndia-UPIKit",url: "https://github.com/payu-intrepos/payu-upi-ios-sdk.git", from: "6.0.2")
    ],
    targets: [
        .binaryTarget(name: "PayUCheckoutProBaseKit", path: "./PayUCheckoutProBaseKit/PayUCheckoutProBaseKit.xcframework"),
        .binaryTarget(name: "PayUCheckoutProKit", path: "./PayUCheckoutProKit/PayUCheckoutProKit.xcframework"),
        .target(
            name: "PayUIndia-CheckoutProBaseTarget",
            dependencies: [
                .product(name: "PayUIndia-PayUParams", package: "PayUIndia-PayUParams"),
                "PayUCheckoutProBaseKit",
            ],
            path: "Wrappers/PayUIndia-CheckoutProBaseWrapper"
        ),
        .target(
            name: "PayUIndia-CheckoutProTarget",
            dependencies: [
                .product(name: "PayUIndia-PayUParams", package: "PayUIndia-PayUParams"),
                .product(name: "PayUIndia-UPICore", package: "PayUIndia-UPIKit"),
                "PayUCheckoutProKit",
                "PayUCheckoutProBaseKit",
                "PayUIndia-Analytics",
                "PayUIndia-NetworkReachability",
                "PayUIndia-CrashReporter",
                "PayUIndia-AssetLibrary",
                "PayUIndia-PG-SDK",
                "PayUIndia-NativeOtpAssist",
                "PayUIndia-Custom-Browser"
            ],
            path: "Wrappers/PayUIndia-CheckoutProWrapper"
        ),
    ]
)
