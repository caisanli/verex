//
//  UserView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/10.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var login: LoginVM
    var body: some View {
        VStack(alignment: .leading) {
            if login.isLogin {
                UserInfo(user: login.user!)
            } else {
                NavigationLink {
                    LoginView()
                } label: {
                    Button {
                        print("去登录了")
                    } label: {
                        Text("去登录")
                    }
                    .buttonStyle(.borderedProminent)

                }


            }
        }
        .font(.system(size: 14))
        .padding()
    }
    
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
