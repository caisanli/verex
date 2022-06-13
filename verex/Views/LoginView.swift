//
//  LoginView.swift
//  verex
//
//  Created by 蔡三李 on 2022/6/11.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var code: String = ""
    @State private var once: String = ""
    @State private var codeImage: String = "https://www.v2ex.com/_captcha"
    
    var body: some View {
        VStack {
            
            Form {
                Text("verex")
                    .font(.largeTitle)
                    .padding(.bottom)
                    .padding(.top, 8)
                TextField("用户名/邮箱", text: $username)
                SecureField("密码", text: $password)
                HStack {
                    TextField("验证码", text: $code)
                    AsyncImage(url: URL(string: codeImage)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 36, alignment: .center)

                }
                
                HStack {
                    Spacer()
                    Button("登录") {
                        print("登录")
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                .padding(.vertical, 8)
                
            }
            .font(.system(size: 14))
            
        }
        .navigationTitle("登录")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getLoginParamsKey()
        }
    }
    
    func getLoginParamsKey() {
        RequestManager.getLoginHtml { html in
            let paramsKey = LOGIN_PARAMS_KEY(from: html)
//            paramsKey.code
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
