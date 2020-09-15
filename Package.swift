// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "vapor",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "Vapor", targets: ["Vapor"]),
        .library(name: "XCTVapor", targets: ["XCTVapor"]),
    ],
    dependencies: [
        // HTTP client library built on SwiftNIO
        .package(url: "https://github.com/val-verde/async-http-client.git", .branch("val-verde-mainline")),
    
        // Sugary extensions for the SwiftNIO library
        .package(url: "https://github.com/val-verde/async-kit.git", .branch("val-verde-mainline")),

        // 💻 APIs for creating interactive CLI tools.
        .package(url: "https://github.com/val-verde/console-kit.git", .branch("val-verde-mainline")),

        // 🔑 Hashing (BCrypt, SHA2, HMAC), encryption (AES), public-key (RSA), and random data generation.
        .package(url: "https://github.com/val-verde/swift-crypto.git", .branch("val-verde-mainline")),

        // 🚍 High-performance trie-node router.
        .package(url: "https://github.com/val-verde/routing-kit.git", .branch("val-verde-mainline")),

        // 💥 Backtraces for Swift on Linux
        .package(url: "https://github.com/val-verde/swift-backtrace.git", .branch("val-verde-mainline")),
        
        // Event-driven network application framework for high performance protocol servers & clients, non-blocking.
        .package(url: "https://github.com/val-verde/swift-nio.git", .branch("val-verde-mainline")),
        
        // Bindings to OpenSSL-compatible libraries for TLS support in SwiftNIO
        .package(url: "https://github.com/val-verde/swift-nio-ssl.git", .branch("val-verde-mainline")),
        
        // HTTP/2 support for SwiftNIO
        .package(url: "https://github.com/val-verde/swift-nio-http2.git", .branch("val-verde-mainline")),
        
        // Useful code around SwiftNIO.
        .package(url: "https://github.com/val-verde/swift-nio-extras.git", .branch("val-verde-mainline")),
        
        // Swift logging API
        .package(url: "https://github.com/val-verde/swift-log.git", .branch("val-verde-mainline")),

        // Swift metrics API
        .package(url: "https://github.com/val-verde/swift-metrics.git", .branch("val-verde-mainline")),

        // WebSocket client library built on SwiftNIO
        .package(url: "https://github.com/val-verde/websocket-kit.git", .branch("val-verde-mainline")),
        
        // MultipartKit, Multipart encoding and decoding
        .package(url: "https://github.com/vapor/multipart-kit.git", from: "4.2.1"),
    ],
    targets: [
        // C helpers
        .target(name: "CBase32"),
        .target(name: "CBcrypt"),
        .target(name: "COperatingSystem"),
        .target(name: "CURLParser"),

        // Vapor
        .target(name: "Vapor", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "AsyncKit", package: "async-kit"),
            .product(name: "Backtrace", package: "swift-backtrace"),
            .target(name: "CBase32"),
            .target(name: "CBcrypt"),
            .target(name: "COperatingSystem"),
            .target(name: "CURLParser"),
            .product(name: "ConsoleKit", package: "console-kit"),
            .product(name: "Logging", package: "swift-log"),
            .product(name: "Metrics", package: "swift-metrics"),
            .product(name: "NIO", package: "swift-nio"),
            .product(name: "NIOExtras", package: "swift-nio-extras"),
            .product(name: "NIOFoundationCompat", package: "swift-nio"),
            .product(name: "NIOHTTPCompression", package: "swift-nio-extras"),
            .product(name: "NIOHTTP1", package: "swift-nio"),
            .product(name: "NIOHTTP2", package: "swift-nio-http2"),
            .product(name: "NIOSSL", package: "swift-nio-ssl"),
            .product(name: "NIOWebSocket", package: "swift-nio"),
            .product(name: "Crypto", package: "swift-crypto"),
            .product(name: "RoutingKit", package: "routing-kit"),
            .product(name: "WebSocketKit", package: "websocket-kit"),
            .product(name: "MultipartKit", package: "multipart-kit"),
        ]),
	
        // Development
        .target(name: "Development", dependencies: [
            .target(name: "Vapor"),
        ], swiftSettings: [
            // Enable better optimizations when building in Release configuration. Despite the use of
            // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
            // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
            .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
        ]),

        // Testing
        .target(name: "XCTVapor", dependencies: [
            .target(name: "Vapor"),
        ]),
        .testTarget(name: "VaporTests", dependencies: [
            .product(name: "NIOTestUtils", package: "swift-nio"),
            .target(name: "XCTVapor"),
        ]),
    ]
)
