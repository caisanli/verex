//
//  SettingView.swift
//  verex
//
//  Created by 蔡三李 on 2022/6/18.
//

import SwiftUI

struct SettingView: View {
    
    @State var isActive = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var login: LoginVM
    
    var body: some View {
        VStack {
            List {
                
                Section {
                    Link("源码开放", destination: URL(string: "https://github.com/CaisanLi/verex")!)
                    Link("帮助与反馈", destination: URL(string: "https://www.v2ex.com/help")!)
                }
                
                Section {
                    Text("退出登录")
                        .foregroundColor(.red)
                        .onTapGesture {
                            logout()
                        }
                }
            }

        }
        .navigationTitle("设置")
        .font(.system(size: 14))
    }
    
    func logout() {
        login.clean()
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
