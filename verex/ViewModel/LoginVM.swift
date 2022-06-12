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
//    @Published var loginForm: LoginForm = LoginForm()
    
    func login() {
        
    }
}
