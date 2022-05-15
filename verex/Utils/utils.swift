//
//  utils.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/14.
//

import Foundation

func runInMain(delay: Int = 0, execute work: @escaping @convention(block) () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(delay), execute: work)
}
