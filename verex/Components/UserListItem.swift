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
    var rightText: String
    var destination: (() -> Destination)? = nil
    
    init(
        icon: String,
        title: String,
        isLast: Bool = false,
        rightText: String = "",
        @ViewBuilder destination: @escaping () -> Destination
    ) {
            self.icon = icon
            self.title = title
            self.rightText = rightText
            self.isLast = isLast
            self.destination = destination
        }
    
    var body: some View {
        
        NavigationLink {
            if rightText.isEmpty {
                destination?()
            }
        } label: {
            HStack(alignment: .top) {
                Image(systemName: icon)
                VStack {
                    HStack {
                        Text(title)
                        Spacer()
                        HStack {
                            if !rightText.isEmpty {
                                Text(rightText)
                            }
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
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
