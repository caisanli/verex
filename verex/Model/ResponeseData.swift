//
//  ResponeseData.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/17.
//

import Foundation

struct ResponeseData<T: Codable>: Codable {
    var success: Bool
    var message: String
    var result: T?
}
