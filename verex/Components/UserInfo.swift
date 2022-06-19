//
//  UserInfo.swift
//  verex
//
//  Created by 蔡三李 on 2022/6/16.
//

import SwiftUI

struct UserInfo: View {
    let user: Member
    
    var body: some View {
        VStack {
            // 用户信息
            HStack(alignment: .top) {
                AvatarView(url: user.avatarLarge, size: 60)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.username)
                        .foregroundColor(.black)
                        .font(.system(size: 28))
                    
                    Text("\(transformDateToString(user.created)) 加入")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.bottom)
            
            VStack {
                UserListItem(icon: "paperplane", title: "主题") {
                    Text("Test")
                }
                
                UserListItem(icon: "bookmark", title: "收藏") {
                    Text("Test")
                }
                
                UserListItem(icon: "heart", title: "关注") {
                    Text("Test")
                }
                
                UserListItem(icon: "clock", title: "最近浏览", isLast: true) {
                    Text("Test")
                }
            }
            .padding(.horizontal)
            .background(Color(red: 245/255, green: 249/255, blue: 255/255))
            .cornerRadius(4)
            .padding(.bottom, 16)
            
            VStack {
                
                UserListItem(icon: "gear", title: "设置") {
                    SettingView()
                }
                
                UserListItem(icon: "info.circle", title: "关于", isLast: true) {
                    Text("Test")
                }
                
            }
            .padding(.horizontal)
            .background(Color(red: 245/255, green: 249/255, blue: 255/255))
            .cornerRadius(4)
            
            Spacer()
        }
    }
    
    /// 时间格式转换为string
    /// - Parameter time: 秒
    /// - Returns: 字符串
    func transformDateToString(_ time: Int) -> String {
        let interval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: interval)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

//struct UserInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        UserInfo()
//    }
//}
