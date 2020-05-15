//
//  File.swift
//  
//
//  Created by xj on 2020/3/31.
//

import Vapor
import AsyncHTTPClient

public struct WxPayClient {
    public init(appId: String, appSecret: String, mchId: String, mchSecret: String, isSandBox: Bool = false) {
        self.appId = appId
        self.mchId = mchId
        self.appSecret = appSecret
        self.mchSecret = mchSecret
        self.isSandBox = isSandBox
    }
    
    let appId: String
    let appSecret: String
    let mchId: String
    let mchSecret: String
    var isSandBox: Bool = false
    
    public var signType = WxPayConst.SignType.md5
    
    public var httpConnectTimeout: Int64 = 3
    public var httpReadTimeout: Int64  = 1
}

extension WxPayClient {
    
    func postWithParam<P: WxParams>(url: WxPayConst.Url, params: P, req: Request) throws -> EventLoopFuture<ClientResponse> {
        
        let dics = try generateParams(param: params)
        
        return req.client.post(URI(string: url.str)) { req in
            try req.content.encode(dics.xmlString)
        }
    }

}

