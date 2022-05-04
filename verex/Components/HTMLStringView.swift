//
//  HTMLStringView.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/4.
//

import Foundation
import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        print(htmlContent)
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
