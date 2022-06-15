//
//  verexApp.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/6.
//

import SwiftUI

@main
struct verexApp: App {
    var login: LoginVM = LoginVM()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(login)
        }
    }
}
