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
        print("url：\(url)");
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
    
}
