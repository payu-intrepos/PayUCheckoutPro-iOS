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
        .package(name: "PayUIndia-PayUParams",url: "https://github.com/payu-intrepos/payu-params-iOS.git", from: "3.1.0"),
        .package(name: "PayUIndia-NetworkReachability",url: "https://github.com/payu-intrepos/PayUNetworkReachability-iOS.git", from: "2.0.0"),
        .package(name: "PayUIndia-Analytics",url: "https://github.com/payu-intrepos/PayUAnalytics-iOS.git", from: "2.0.0"),
        .package(name: "PayUIndia-CrashReporter",url: "https://github.com/payu-intrepos/PayUCrashReporter-iOS.git", from: "2.0.0"),
        .package(name: "PayUIndia-AssetLibrary",url: "https://github.com/payu-intrepos/PayUAssetLibrary-iOS.git", from: "3.0.0"),
        .package(name: "PayUIndia-PG-SDK",url: "https://github.com/payu-intrepos/iOS-SDK.git", .exact("7.1.0")),
        .package(name: "PayUIndia-Custom-Browser",url: "https://github.com/payu-intrepos/iOS-Custom-Browser.git", .exact("8.0.0")),
        .package(name: "PayUIndia-NativeOtpAssist",url: "https://github.com/payu-intrepos/PayUNativeOtpAssist-iOS.git", from: "2.0.0"),
        .package(name: "PayUIndia-UPIKit",url: "https://github.com/payu-intrepos/payu-upi-ios-sdk.git", .exact("6.0.0")),
    ],
    targets: [
            .binaryTarget(name: "PayUIndia-CheckoutProBase", path: "./PayUCheckoutProBaseKit/PayUCheckoutProBaseKit.xcframework"),
                .target(
                    name: "PayUIndia-CheckoutProBaseTarget",
                    dependencies: [
                        .target(name: "PayUIndia-CheckoutProBase", condition: .when(platforms: [.iOS])),
                        .product(name: "PayUIndia-PayUParams", package: "PayUIndia-PayUParams"),
                    ],
                    path: "Wrappers/PayUIndia-CheckoutProBaseWrapper"
                ),
            .binaryTarget(name: "PayUIndia-CheckoutPro", path: "./PayUCheckoutProKit/PayUCheckoutProKit.xcframework"),
                .target(
                    name: "PayUIndia-CheckoutProTarget",
                    dependencies: [
                        .target(name: "PayUIndia-CheckoutPro", condition: .when(platforms: [.iOS])),
                        .product(name: "PayUIndia-PayUParams", package: "PayUIndia-PayUParams"),
                        .product(name: "PayUIndia-UPICore", package: "PayUIndia-UPIKit"),
                        "PayUIndia-CheckoutProBase",
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