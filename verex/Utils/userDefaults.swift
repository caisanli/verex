//
//  userDefaults.swift
//  verex
//
//  Created by 蔡三李 on 2022/6/2.
//  参考 https://www.jianshu.com/p/3796886b4953
//

import Foundation

struct UserDefaultKeys {
    enum DefaultKeys: String {
       case searchHistory
    }
    
    static func set<T>(value: T, key: DefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func string(_ key: DefaultKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue);
    }
}

