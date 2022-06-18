//
//  UserView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/10.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var login: LoginVM
    @State var goLogin = false
    var body: some View {
        VStack(alignment: .leading) {
            if login.isLogin {
                UserInfo(user: login.user!)
            } else {
                NavigationLink {
                    LoginView()
                } label: {
                    Button {
                        self.goLogin = true
                    } label: {
                        Text("去登录")
                    }
                    .buttonStyle(.borderedProminent)

                }
                
                NavigationLink(isActive: $goLogin) {
                    LoginView()
                } label: {
                    EmptyView()
                }

            }
        }
        .font(.system(size: 14))
        .padding()
    }
    
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
