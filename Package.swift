// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let VERSION_PARAM_KIT: PackageDescription.Version = "5.2.0"
let VERSION_ANALYTICS_KIT: PackageDescription.Version = "3.0.0"
let VERSION_CRASH_REPORTER: PackageDescription.Version = "3.0.0"
let VERSION_NETWORK_REACHABILITY: PackageDescription.Version = "2.0.1"
let VERSION_ASSET_LIBRARY: PackageDescription.Version = "3.3.1"
let VERSION_PG_SDK: PackageDescription.Version = "10.3.0"
let VERSION_CUSTOM_BROWSER: PackageDescription.Version = "10.1.0"
let VERSION_NATIVE_OTP_ASSIST: PackageDescription.Version = "3.2.0"
let VERSION_UPI_KIT: PackageDescription.Version = "9.0.0"
let VERSION_CARD_SCANNER: PackageDescription.Version = "1.0.0"
let VERSION_COMMON_UI: PackageDescription.Version = "1.2.0"

let package = Package(
    name: "PayUCheckoutProKit",
    platforms: [.iOS(.v11)],

    products: [
        .library(
            name: "PayUIndia-CheckoutProBase",
            targets: ["PayUIndia-CheckoutProBaseTarget"]
        ),
        .library(
            name: "PayUIndia-CheckoutPro",
            targets: ["PayUIndia-CheckoutProTarget"]
        )
    ],

    dependencies: [
        .package(name: "PayUIndia-PayUParams", url: "https://github.com/payu-intrepos/payu-params-iOS.git", from: VERSION_PARAM_KIT),
        .package(name: "PayUIndia-NetworkReachability", url: "https://github.com/payu-intrepos/PayUNetworkReachability-iOS.git", from: VERSION_NETWORK_REACHABILITY),
        .package(name: "PayUIndia-Analytics", url: "https://github.com/payu-intrepos/PayUAnalytics-iOS.git", from: VERSION_ANALYTICS_KIT),
        .package(name: "PayUIndia-CrashReporter", url: "https://github.com/payu-intrepos/PayUCrashReporter-iOS.git", from: VERSION_CRASH_REPORTER),
        .package(name: "PayUIndia-AssetLibrary", url: "https://github.com/payu-intrepos/PayUAssetLibrary-iOS.git", from: VERSION_ASSET_LIBRARY),
        .package(name: "PayUIndia-PG-SDK", url: "https://github.com/payu-intrepos/iOS-SDK.git", from: VERSION_PG_SDK),
        .package(name: "PayUIndia-Custom-Browser", url: "https://github.com/payu-intrepos/iOS-Custom-Browser.git", from: VERSION_CUSTOM_BROWSER),
        .package(name: "PayUIndia-NativeOtpAssist", url: "https://github.com/payu-intrepos/PayUNativeOtpAssist-iOS.git", from: VERSION_NATIVE_OTP_ASSIST),
        .package(name: "PayUIndia-UPIKit", url: "https://github.com/payu-intrepos/payu-upi-ios-sdk.git", from: VERSION_UPI_KIT),
        .package(name: "PayUIndia-CardScanner", url: "https://github.com/payu-intrepos/PayUIndia-CardScanner-iOS.git", from: VERSION_CARD_SCANNER),
        .package(name: "PayUIndia-CommonUI", url: "https://github.com/payu-intrepos/PayUCommonUI-iOS", from: VERSION_COMMON_UI)
    ],

    targets: [
        .binaryTarget(name: "PayUCheckoutProBaseKit", path: "./PayUCheckoutPro/PayUCheckoutProBaseKit.xcframework"),
        .binaryTarget(name: "PayUCheckoutProKit", path: "./PayUCheckoutPro/PayUCheckoutProKit.xcframework"),
        .target(
            name: "PayUIndia-CheckoutProBaseTarget",
            dependencies: [
                .product(name: "PayUIndia-PayUParams", package: "PayUIndia-PayUParams"),
                "PayUCheckoutProBaseKit"
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
                "PayUIndia-Custom-Browser",
                "PayUIndia-CardScanner",
                "PayUIndia-CommonUI"
            ],
            path: "Wrappers/PayUIndia-CheckoutProWrapper"
        )
    ]
)
