<img src="images/banner.png"/>

[![Build Status](https://img.shields.io/badge/platforms-macOS%20%7C%20Ubuntu-green.svg)](https://github.com/vapor-china/wechat-pay)
[![Swift](https://img.shields.io/badge/Swift-5.2-orange.svg)](https://swift.org)
[![Swift](https://img.shields.io/badge/Vapor-4-orange.svg)](https://vapor.codes)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)
[![Xcode](https://img.shields.io/badge/macOS-15.0-blue.svg)](https://developer.apple.com/macOS)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)



`WechatPay` is a vapor 4 kit of wechat pay service. It support macOS, Ubuntu. You can use the kit to call wechat pay service. 


[中文版🇨🇳](README_CN.md)

## Installation

### Swift Package Manager

To integrate using Apple's Swift package manager, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/vapor-china/wechat-pay.git", from: "1.0.0")
```

Here's an example `PackageDescription`:

```swift
// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor-china/wechat-pay.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "WechatPay", package: "wechat-pay")
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
```

## Usage

### init client
```swift
        let client = WxpayClient(appId: "your appid", mchId: "you mchId", apiKey: "your mch apiKey")
        
```

### unified order
```swift
        let param = WxPayUnifiedOrderPramas(out_trade_no: "macos\(Int(Date().timeIntervalSince1970))", body: "vapor test", total_fee: 1, spbill_create_ip: "127.0.0.1", notify_url: "http://notify.objcoding.com/notify", trade_type: .app)
         
        return try client.unifiedOrder(param, req: req)
```

### query order result
```swift 
    let param = WxpayOrderQueryPramas(out_trade_no: "your out trade no")
        try client.orderQuery(param, req: req)
```

### close order
```swift
    let param = WxpayCloseOrderParams(out_trade_no: "your out trade no")
        client.closeOrder(param, req: req)
```

### refund order
```swift 
    let param = WxpayRefundOrderParams(out_trade_no: "out trade no", out_refund_no: " out refund no", total_fee: 1, refund_fee: 1, refund_fee_type: "", refund_desc: "", refund_account: "", notify_url: "notify url")
        client.refundOrder(param, req: req)
```

### notify parse
router use post
```swift 
    try client.dealwithCallback(req: req)
    ······
    if success {
      return WxpayCallbackReturn.OK.encodeResponse(for: req)
    } else {
      return WxpayCallbackReturn.NotOK(errMsg: "msg").encodeResponse(for: req)
    }   
```



## License

AliSMS is released under an MIT license. See [License.md](https://github.com/vapor-china/wechat-pay/blob/master/LICENSE) for more information.
