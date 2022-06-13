//
//  api.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/7.
//
// https://github.com/djyde/V2EX-API
// https://www.v2ex.com/help/api
// Authorization: Bearer 3de87109-24db-44d6-8375-6b161cce3b58

import Foundation
import Alamofire
import SwiftSoup

// 基础地址
let BASE_URL = "https://www.v2ex.com"
let BASE_API = "\(BASE_URL)/api"

let BaseHeaders: HTTPHeaders = [
    "Authorization": "Bearer 3de87109-24db-44d6-8375-6b161cce3b58"
]

class APIS {
    // ------ API 2.0

    // 获取最新提醒
    // method: GET
    // params: {
    //   p: 1 // 分页页码 默认为 1
    // }
    // https://www.v2ex.com/api/v2/notifications?p=2
    static let GET_NOTIFICATIONS = "\(BASE_API)/v2/notifications"

    // 删除指定提醒
    // method: DELETE
    // reset: :notification_id
    // https://www.v2ex.com/api/v2/notifications/123456
    static let DEL_NOTIFICATION = "\(BASE_API)/v2/notifications"

    // 获取自己的Profile
    // method: GET
    // https://www.v2ex.com/api/v2/member
    static let GET_MEMBER = "\(BASE_API)/v2/member"

    // 获取当前使用的令牌
    // method: GET
    // https://www.v2ex.com/api/v2/token
    static let GET_TOKEN = "\(BASE_API)/v2/token"

    // 创建新的令牌
    // method: POST
    // data: {
    //  scope: 可选 everything 或者 regular，如果是 regular 类型的 Token 将不能用于进一步创建新的 token
    //  expiration: 可支持的值：2592000，5184000，7776000 或者 15552000，即 30 天，60 天，90 天或者 180 天的秒数
    // }
    // https://www.v2ex.com/api/v2/tokens
    static let CREATE_TOKEN = "\(BASE_API)/v2/tokens"

    // 获取指定节点
    // method: GET
    // reset: :node_name
    // https://www.v2ex.com/api/v2/nodes/python
    static let GET_NODE = "\(BASE_API)/v2/nodes"

    // 获取指定节点下的主题
    // method: GET
    // reset :node_name
    // params: {
    //  p: 1 分页页码 默认为 1
    // }
    // https://www.v2ex.com/api/v2/nodes/:node_name/topics?p=2
    static let GET_TOPICES_V2 = "\(BASE_API)/v2/nodes/${node_name}/topics"

    // 获取指定主题
    // method: GET
    // reset: :topic_id
    // https://www.v2ex.com/api/v2/topics/1
    static let GET_TIPC = "\(BASE_API)/v2/topics"

    // 获取指定主题下的回复
    // method: GET
    // reset: :topic_id
    // params: {
    //  p: 1 分页页码 默认为 1
    // }
    // https://www.v2ex.com/api/v2/topics/1/replies?p=2
    static let GET_REPLIES = "\(BASE_API)/v2/topics/${topic_id}/replies"
    
    // ------ API 1.0
    
    /// 获取最新主题
    /// method GET
    static let GET_NEW = "\(BASE_API)/topics/latest.json"
    
    
    /// 获取最热主题
    /// method GET
    static let GET_HOT = "\(BASE_API)/topics/hot.json"
    
    // 根据参数获取主题列表
    // method: GET
    // params: {
    //  node_id 节点id
    //  node_name 节点name
    //  username 用户名称
    //  id 主题id
    // }
    static let GET_TOPICES = "\(BASE_API)/topics/show.json"
    
    // 根据主题ID获取回复列表
    // method: GET
    // params: {
    //  topic_id 主题id
    //  page 当前页
    // }
    static let GET_REPILES = "\(BASE_API)/replies/show.json"
    
    
    /// 获取节点信息
    /// method: GET
    /// params: {
    ///    name 节点 name
    /// }
    static let GET_NODE_INFO = "\(BASE_API)/nodes/show.json"
    
    // ---- GET_HTML
    // 根据 tab 获取主题列表
    // method: GET
    // params: {
    //  tab 节点名
    // }
    static let GET_TAB_TOPICES = "\(BASE_URL)"
    
    
    /// 获取登录页
    /// method GET
    static let GET_LOGIN = "\(BASE_URL)/signin"
    
    
    /// 搜索
    /// method: GET
    /// 见 https://github.com/bynil/sov2ex/blob/v2/API.md#搜索
    /// params: {
    ///   q 关键词
    ///   from 从第几条搜索 默认0
    ///   size 分页数
    /// }
    static let SEARCH = "https://www.sov2ex.com/api/search"

}

struct GET_TOPICES_PARAMS: Codable {
    var node_id: Int?
    var node_name: String?
    var username: String?
    var id: Int?
}

struct GET_REPILES_PARAMS: Codable {
    var topic_id: Int?
    var page: Int?
}

struct GET_TAB_REPILES_PARAMS: Codable {
    var tab: String
}

struct GET_NODE_INFO_PARAMS: Codable {
    var name: String
}

struct SEARCH_PARAMS: Codable {
    var q: String
    var from: Int?
    var size: Int?
}

struct LOGIN_PARAMS_KEY: Codable {
    var name: String = "" // 用户名
    var password: String = "" // 密码
    var once: String = "" // once
    var code: String = "" // 验证码
//    var next
    init(from html: String) {
        do {
            let doc = try SwiftSoup.parse(html)
            let main = try doc.select("#Main")
            self.name = try main.select("input.sl[type=text]").attr("name")
            self.password = try main.select("input[type=password]").attr("name")
            self.once = try main.select("input[name=once]").attr("value")
            self.code = try main.select("input[placeholder*=验证码]").attr("name")

        } catch {
            print(error)
        }
    }
}
