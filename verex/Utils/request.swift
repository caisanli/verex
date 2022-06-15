//
//  request.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/7.
//

import Foundation
import Alamofire
import SwiftSoup

protocol HtmlParsable {
    init?(_ html: Element?)
    init()
}

class RequestManager {
    
    static func parse<T: HtmlParsable>(_ html: String) -> T {
        do {
            let result = try SwiftSoup.parse(html)
            let data = T(result) ?? nil
            return data!;
        } catch {
            print("error：")
            print(error)
            return T()
        }
    }
    
    
    /// 获取节点信息
    /// - Parameters:
    ///   - params: GET_NODE_INFO_PARAMS
    ///   - complate: 查询成功回调函数
    static func getNodeInfo(params: GET_NODE_INFO_PARAMS, complate: ((_ result: Node) -> Void)? = nil) {
        AF.request(APIS.GET_NODE_INFO, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default)
            .validate()
            .responseDecodable(of: Node.self) { response in
                switch response.result {
                case .success(let value):
                    complate?(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    /// 获取登录页html
    /// - Parameter complate: 成功回调函数
    static func getLoginHtml(complate: ((_ result: String) -> Void)? = nil) {
        AF.request(APIS.GET_LOGIN)
            .responseString { response in
                switch response.result {
                case .success(let result):
                    complate?(result)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    /// 登录
    /// - Parameters:
    ///   - data: 参数
    ///   - complate: 成功的回调函数
    static func login(data: Any, complate: ((_ result: String) -> Void)? = nil) {
        let headers: HTTPHeaders = ["Referer": BASE_URL.appending("/signin")]
        AF.request(APIS.POST_LOGIN, method: .post, parameters: data as! Parameters, headers: headers)
            .responseString { response in
//                print(response)
                switch response.result {
                case .success(let value):
                    complate?(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    /// 获取节点导航
    /// - Parameter complate: 查询成功回调函数
    static func getNodeNavigate(complate: ((_ result: NodeNavigateInfo) -> Void)? = nil) {
        AF.request(BASE_URL)
            .responseString { response in
                switch response.result {
                case .success(let result):
                    let data:NodeNavigateInfo = RequestManager.parse(result)
                    complate?(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    /// 获取用户信息
    /// - Parameters:
    ///   - params: GET_MEMBER_PARAMS
    ///   - complate: 成功回调函数
    static func getMember(params: GET_MEMBER_PARAMS, complate: ((_ result: Member) -> Void)? = nil) {
        AF.request(APIS.GET_MEMBER, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default)
            .responseDecodable(of: Member.self) { response in
                switch response.result {
                case .success(let value):
                    complate?(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 根据 tab 查询对应主题列表
    /// - Parameters:
    ///   - params: GET_TAB_REPILES_PARAMS
    ///   - complate: 查询成功的回调函数
    static func queryTopicsByTab(params: GET_TAB_REPILES_PARAMS, complate: ((_ result: [Any]) -> Void)? = nil) {
        AF.request(APIS.GET_TAB_TOPICES, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default)
            .responseString { response in
                switch response.result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 获取主题列表
    /// - Parameters:
    ///   - params: GET_TOPICES_PARAMS 一些参数
    ///   - complate: 回调函数
    static func queryTopics(params: GET_TOPICES_PARAMS, complate: ((_ result: [Topic]) -> Void)?) {
        AF.request(APIS.GET_TOPICES, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: BaseHeaders)
            .validate()
            .responseDecodable(of: [Topic].self) { response in
                switch response.result {
                case .success(let value):
                    complate?(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    /// 获取主题下的回复列表
    /// - Parameters:
    ///   - params: GET_TOPICES_PARAMS
    ///   - complate: 回调函数
    static func getRelipes(params: GET_REPILES_PARAMS, complate: ((_ result: [Replies]) -> Void)?) {
        AF.request(APIS.GET_REPILES, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: BaseHeaders)
            .validate()
            .responseDecodable(of: [Replies].self) { response in
                switch response.result {
                case .success(let value):
                    complate?(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    /// 根据节点name获取主题列表
    /// - Parameters:
    ///   - name: 节点 name
    ///   - p: 分页数
    ///   - complate: 回调函数
    static func getTopicsByNodeName(name: String, p: Int, complate: ((_ result: [Topic]) -> Void)?) {
        let url = APIS.GET_TOPICES.replacingOccurrences(of: "${node_name}", with: name);
        let parameters = ["p": p]
        AF.request(url, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: BaseHeaders)
            .validate()
            .responseDecodable(of: ResponeseData<[Topic]>.self) { response in
            switch response.result {
            case .success(let value):
                complate?(value.result ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    /// 搜索
    /// - Parameters:
    ///   - params: 搜索参数 SEARCH_PARAMS
    ///   - complate: 回调函数
    static func search(params: SEARCH_PARAMS, complate: ((_ result: SearchResponse) -> Void)? = nil) {
        AF.request(APIS.SEARCH, method: .get, parameters: params, encoder: .urlEncodedForm)
            .validate()
            .responseDecodable(of: SearchResponse.self) { response in
                switch response.result {
                case .success(let value):
                    complate?(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    /// 获取最新主题
    /// - Parameter complate: 回调函数
    static func getNew(complate: ((_ result: [Topic]) -> Void)? = nil) {
        AF.request(APIS.GET_NEW, method: .get)
            .responseDecodable(of: [Topic].self) { response in
                switch response.result {
                case .success(let value):
                    complate?(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    /// 获取最热主题
    /// - Parameter complate: 回调函数
    static func getHot(complate: ((_ result: [Topic]) -> Void)? = nil) {
        AF.request(APIS.GET_HOT, method: .get)
            .responseDecodable(of: [Topic].self) { response in
                switch response.result {
                case .success(let value):
                    complate?(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
//    static func get
    
}
