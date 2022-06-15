//
//  LoginVM.swift
//  verex
//
//  Created by 蔡三李 on 2022/6/12.
//

import Foundation

class LoginVM: ObservableObject {
    @Published var isLogin: Bool = false
    @Published var user: Member? = nil
    
    init() {
        self.getMember()
    }
    
    func getMember() {
        let username = UserDefaultKeys.string(.loginUser) ?? ""
        
        guard !username.isEmpty else {
            self.isLogin = false
            return
        }
        
        let params = GET_MEMBER_PARAMS(username: username)
        RequestManager.getMember(params: params) { member in
            self.user = member
        }
    }
}
