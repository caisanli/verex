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

// 基础地址
let HOST_URL = "https://www.v2ex.com/api"

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
    static let GET_NOTIFICATIONS = "\(HOST_URL)/v2/notifications"

    // 删除指定提醒
    // method: DELETE
    // reset: :notification_id
    // https://www.v2ex.com/api/v2/notifications/123456
    static let DEL_NOTIFICATION = "\(HOST_URL)/v2/notifications"

    // 获取自己的Profile
    // method: GET
    // https://www.v2ex.com/api/v2/member
    static let GET_MEMBER = "\(HOST_URL)/v2/member"

    // 获取当前使用的令牌
    // method: GET
    // https://www.v2ex.com/api/v2/token
    static let GET_TOKEN = "\(HOST_URL)/v2/token"

    // 创建新的令牌
    // method: POST
    // data: {
    //  scope: 可选 everything 或者 regular，如果是 regular 类型的 Token 将不能用于进一步创建新的 token
    //  expiration: 可支持的值：2592000，5184000，7776000 或者 15552000，即 30 天，60 天，90 天或者 180 天的秒数
    // }
    // https://www.v2ex.com/api/v2/tokens
    static let CREATE_TOKEN = "\(HOST_URL)/v2/tokens"

    // 获取指定节点
    // method: GET
    // reset: :node_name
    // https://www.v2ex.com/api/v2/nodes/python
    static let GET_NODE = "\(HOST_URL)/v2/nodes"

    // 获取指定节点下的主题
    // method: GET
    // reset :node_name
    // params: {
    //  p: 1 分页页码 默认为 1
    // }
    // https://www.v2ex.com/api/v2/nodes/:node_name/topics?p=2
    static let GET_TOPICES_V2 = "\(HOST_URL)/v2/nodes/${node_name}/topics"

    // 获取指定主题
    // method: GET
    // reset: :topic_id
    // https://www.v2ex.com/api/v2/topics/1
    static let GET_TIPC = "\(HOST_URL)/v2/topics"

    // 获取指定主题下的回复
    // method: GET
    // reset: :topic_id
    // params: {
    //  p: 1 分页页码 默认为 1
    // }
    // https://www.v2ex.com/api/v2/topics/1/replies?p=2
    static let GET_REPLIES = "\(HOST_URL)/v2/topics/${topic_id}/replies"
    
    // ------ API 1.0
    
    // 根据参数获取主题列表
    // method: GET
    // params: {
    //  node_id 节点id
    //  node_name 节点name
    //  username 用户名称
    // }
    static let GET_TOPICES = "\(HOST_URL)/topics/show.json"
}

struct GET_TOPICES_PARAMS: Codable {
    var node_id: Int?
    var node_name: String?
    var username: String?
}
