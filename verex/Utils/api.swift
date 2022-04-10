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

// 基础地址
let HOST_URL = "https://www.v2ex.com/api"

// ------ API 2.0

// 获取最新提醒
// method: GET
// params: {
//   p: 1 // 分页页码 默认为 1
// }
// https://www.v2ex.com/api/v2/notifications?p=2
let GET_NOTIFICATIONS = "/v2/notifications"

// 删除指定提醒
// method: DELETE
// reset: :notification_id
// https://www.v2ex.com/api/v2/notifications/123456
let DEL_NOTIFICATION = "/v2/otifications"

// 获取自己的Profile
// method: GET
// https://www.v2ex.com/api/v2/member
let GET_MEMBER = "/v2/member"

// 获取当前使用的令牌
// method: GET
// https://www.v2ex.com/api/v2/token
let GET_TOKEN = "/v2/token"

// 创建新的令牌
// method: POST
// data: {
//  scope: 可选 everything 或者 regular，如果是 regular 类型的 Token 将不能用于进一步创建新的 token
//  expiration: 可支持的值：2592000，5184000，7776000 或者 15552000，即 30 天，60 天，90 天或者 180 天的秒数
// }
// https://www.v2ex.com/api/v2/tokens
let CREATE_TOKEN = "/v2/tokens"

// 获取指定节点
// method: GET
// reset: :node_name
// https://www.v2ex.com/api/v2/nodes/python
let GET_NODE = "/v2/nodes"

// 获取指定节点下的主题
// method: GET
// reset :node_name
// params: {
//  p: 1 分页页码 默认为 1
// }
// https://www.v2ex.com/api/v2/nodes/:node_name/topics?p=2
let GET_TOPICES = "/v2/nodes/${node_name}/topics"

// 获取指定主题
// method: GET
// reset: :topic_id
// https://www.v2ex.com/api/v2/topics/1
let GET_TIPC = "/v2/topics"

// 获取指定主题下的回复
// method: GET
// reset: :topic_id
// params: {
//  p: 1 分页页码 默认为 1
// }
// https://www.v2ex.com/api/v2/topics/1/replies?p=2
let GET_REPLIES = "/v2/topics/${topic_id}/replies"
