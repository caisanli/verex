//
//  LoginView.swift
//  verex
//
//  Created by 蔡三李 on 2022/6/11.
//

import SwiftUI
import SwiftSoup

struct LoginView: View {
    @EnvironmentObject var login: LoginVM
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let baseCodeImage: String = "https://www.v2ex.com/_captcha"
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var code: String = ""
    @State private var once: String = ""
    @State private var codeImage: String = ""
    @State private var paramskey: LOGIN_PARAMS_KEY? = nil
    
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
                        .textInputAutocapitalization(.none)
                    
                    AsyncImage(url: URL(string: codeImage)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 36, alignment: .center)
                    .onTapGesture {
                        codeImage = baseCodeImage + "?now=\(Int(Date().timeIntervalSince1970))"
                    }
                    
                }
                
                HStack {
                    Spacer()
                    Button("登录") {
                        submitlogin()
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
            codeImage = baseCodeImage
            getLoginParamsKey()
        }
    }
    
    func submitlogin() {
        guard paramskey != nil else {
            print("没获取到 => paramskey")
            return
        }
        
        var form: [String:String] = [:]
        form[paramskey!.name] = username
        form[paramskey!.password] = password
        form[paramskey!.code] = code
        form["once"] = paramskey!.once
        // 设置登录成功后重定向地址
        form["next"] = "/"
        RequestManager.login(data: form) { html in
            checkLogin(html)
        }
    }
    
    func checkLogin(_ html: String) {
        do {
            let doc = try SwiftSoup.parse(html)
            let userImg = try doc.select("#Rightbar img.avatar")
            if userImg.count > 0 {
                getLoginUser()
            } else {
                print("登录失败")
            }
        } catch {
            print(error)
        }
    }
    
    func getLoginUser() {
        let params = GET_MEMBER_PARAMS(username: username)
        RequestManager.getMember(params: params) { member in
            login.isLogin = true
            login.user = member
            UserDefaultKeys.set(value: username, key: .loginUser)
            // 返回上一页
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    /// 获取登录参数的key
    func getLoginParamsKey() {
        RequestManager.getLoginHtml { html in
            self.paramskey = LOGIN_PARAMS_KEY(from: html)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
