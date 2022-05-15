//
//  String.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/14.
//

import Foundation

extension String {
    static let `default`: String = ""
    public static let empty = `default`
    
    func urlEncoded()-> String {
        let result = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return result ?? .empty
    }

    func urlDecode()-> String {
        self.removingPercentEncoding ?? .empty
    }
    
    func replace(segs: String..., with replacement: String) -> String {
        var result: String = self
        
        for seg in segs {
            guard result.contains(seg) else {
                continue
            }
            result = result.replacingOccurrences(of: seg, with: replacement)
        }
        
        return result
    }
}
