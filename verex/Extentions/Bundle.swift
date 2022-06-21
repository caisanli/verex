//
//  Bundle.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/15.
//

import Foundation


extension Bundle {
    static func readString(name: String?, type: String?) -> String? {
        var result: String? = nil
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                result = try String(contentsOfFile: path)
            } catch {
                print("contents could not be loaded")
            }
        } else {
            print("local resource \(name ?? "") not found")
        }
        return result
    }
    
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0")"
    }
}
