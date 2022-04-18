//
//  request.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/7.
//

import Foundation
import Alamofire

class RequestManager {
    
    
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
                    print(value)
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
