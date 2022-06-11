//
//  UserView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/10.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        VStack(alignment: .leading) {
            // 用户信息
            HStack(alignment: .top) {
                AvatarView(url: "https://cdn.v2ex.com/avatar/bc4c/729a/498093_xlarge.png?m=1644990034", size: 60)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("caisanli")
                        .foregroundColor(.black)
                        .font(.system(size: 28))
                    
                    Text("\(transformDateToString(1594111624)) 加入")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.bottom)
                    
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "paperplane")
                        
                    VStack {
                        HStack {
                            Text("主题")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        Divider()
                            .background(.white)
                    }
                }
                
                HStack(alignment: .top) {
                    Image(systemName: "bookmark")
                    VStack {
                        HStack {
                            Text("收藏")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        
                        Divider()
                            .background(.white)
                    }
                }
                .padding(.top, 8)
                
                HStack(alignment: .top) {
                    Image(systemName: "heart")
                    VStack {
                        HStack {
                            Text("关注")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        Divider()
                            .background(.white)
                    }
                }
                .padding(.top, 8)
                
                HStack(alignment: .top) {
                    Image(systemName: "clock")
                    VStack {
                        HStack {
                            Text("最近浏览")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.top, 8)
            }
            
            .padding()
            .background(Color(red: 245/255, green: 249/255, blue: 255/255))
            .cornerRadius(4)
            
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "gear")
                        
                    VStack {
                        HStack {
                            Text("设置")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        Divider()
                            .background(.white)
                    }
                }
                
                HStack(alignment: .top) {
                    Image(systemName: "info.circle")
                        
                    VStack {
                        HStack {
                            Text("关于")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }

                    }
                }
                .padding(.top, 8)
            }
            .padding()
            .background(Color(red: 245/255, green: 249/255, blue: 255/255))
            .cornerRadius(4)
            
            Spacer()
        }
        .font(.system(size: 14))
        .padding()
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

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
