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
    @Binding var dynamicHeight: CGFloat
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView();
        webview.scrollView.bounces = false
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let newHtml = "<html><head><meta name='viewport' content='width=device-width,initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'><style>body { font-size: 14px; line-height: 1.6; color: #000; word-break: break-word; margin: 0; padding: 0; } img { max-width: 100%; }</style></head><body>\(htmlContent)</body></html>"
        uiView.loadHTMLString(newHtml, baseURL: nil)
        uiView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                uiView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (result, _) in
                    if let height = result as? CGFloat {
                        dynamicHeight = height;
                    }
                })
            }

        })
    }
}
