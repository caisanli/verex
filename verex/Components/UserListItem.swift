//
//  UserListItem.swift
//  verex
//
//  Created by 蔡三李 on 2022/6/12.
//

import SwiftUI

struct UserListItem<Destination: View>: View {
    var icon: String
    var title: String
    var isLast: Bool
    var destination: () -> Destination
    
    init(
        icon: String,
        title: String,
        isLast: Bool? = nil,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
            self.icon = icon
            self.title = title
            self.isLast = isLast ?? true
            self.destination = destination
        }
    
    var body: some View {
        
        NavigationLink {
            destination()
        } label: {
            HStack(alignment: .top) {
                Image(systemName: icon)
                VStack {
                    HStack {
                        Text(title)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    Divider()
                    
                }
            }
            
        }
        .padding(.top, 12)
        .foregroundColor(.black)
    }
    
    
    
}

struct UserListItem_Previews: PreviewProvider {
    static var previews: some View {
        UserListItem(icon: "star", title: "收藏") {
            Text("提示")
        }
    }
}
