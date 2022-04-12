//
//  HomeHead.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/12.
//

import SwiftUI

struct HomeHead: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("Verex").foregroundColor(.black)
                .font(.title)
                .fontWeight(.black)
            
            Spacer();
            
            HStack(alignment: .center) {
                NavigationLink {
                    Text("search")
                } label: {
                    Image(systemName: "magnifyingglass")
                }

                NavigationLink {
                    Text("Notifications")
                } label: {
                    Image(systemName: "message")
                }
                
                NavigationLink {
                    Text("User")
                } label: {
                    Image(systemName: "person.circle")
                }
            }
            .foregroundColor(.black)
        }
        .padding(
            EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        )
    }
}

struct HomeHead_Previews: PreviewProvider {
    static var previews: some View {
        HomeHead()
    }
}
