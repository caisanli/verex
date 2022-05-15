//
//  HTMLStringView.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/4.
//

import Foundation
import UIKit
import SwiftUI
import WebKit
import Kingfisher

//struct HTMLStringView: UIViewRepresentable {
//    @Binding var dynamicHeight: CGFloat
//    let htmlContent: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webview = WKWebView();
//        webview.scrollView.bounces = false
//        return webview
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        let newHtml = "<html><head><meta name='viewport' content='width=device-width,initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'><style>body { font-size: 14px; line-height: 1.6; color: #333; word-break: break-word; margin: 0; padding: 0; } img { max-width: 100%; }</style></head><body>\(htmlContent)</body></html>"
//        uiView.loadHTMLString(newHtml, baseURL: nil)
//        uiView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
//            if complete != nil {
//                uiView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (result, _) in
//                    if let height = result as? CGFloat {
//                        dynamicHeight = height;
//                    }
//                })
//            }
//
//        })
//    }
//}

// MARK: - WebViewHandlerDelegate
// For printing values received from web app
protocol WebViewHandlerDelegate {
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}

struct HtmlView: View {
    let html: String
    @State var height: CGFloat = 0
    @Binding var rendered: Bool

    var body: some View {
        GeometryReader { geo in
            WebView(html: html, height: $height, rendered: $rendered)
        }
        .frame(height: height)
    }
}

fileprivate struct WebView: UIViewRepresentable, WebViewHandlerDelegate {
    let html: String
    @Binding var height: CGFloat
    @Binding var rendered: Bool
    @State var loaded: Bool = false
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
                
        // enable javascript in WKWebView
        let preferences = WKPreferences()
        let wkpref = WKWebpagePreferences()
        wkpref.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(self.makeCoordinator(), name: "iOSNative")
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.isScrollEnabled = false
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let baseUrl = Bundle.main.bundleURL
        let isDark = false
        let fontSize = 16
        let params = "\(isDark),\(fontSize)"
        var content = Bundle.readString(name: "www/v2er", type: "html")
        content = content?.replace(segs: "{injecttedContent}", with: html)
            .replace(segs: "{INJECT_PARAMS}", with: params)
                
        webView.loadHTMLString(content ?? "", baseURL: baseUrl)
    }
    
    func receivedJsonValueFromWebView(value: [String : Any?]) {
        print("JSON value received from web is: \(value)")
    }

    func receivedStringValueFromWebView(value: String) {
        print("String value received from web is: \(value)")
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: WebView
        var delegate: WebViewHandlerDelegate?
        var imgLoaded: Bool = false
        
        init(_ webview: WebView) {
            self.parent = webview
            self.delegate = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "iOSNative" {
                if let body = message.body as? [String: Any?] {
                    imgLoaded = true
                    delegate?.receivedJsonValueFromWebView(value: body)
                } else if let body = message.body as? String {
                    delegate?.receivedStringValueFromWebView(value: body)
                }
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
            let url = navigationAction.request.url
            let navType = navigationAction.navigationType
            guard url != nil else { return .allow }
            guard navType == .linkActivated else { return .allow }
            if url!.absoluteString.starts(with: "file:") {
                return .allow
            }
            
            // TODO: open in internal webview/safari
            await UIApplication.shared.open(url!)
            return .cancel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if webView.isLoading {
                return 
            }
            
//            downloadImgs(webView)
            injectImgClicker(webView)
            measureHeightOfHtml(webView)
        }
        
//        private func downloadImgs(_ webview: WKWebView) {
//            for img in self.parent.imgs {
//                let url = URL(string: img)!
//                KingfisherManager.shared.retrieveImage(with: url) { result in
//                    Task {
//                        var base64DataOrPath: String
//                        if case let .success(imgData) = result {
//                            base64DataOrPath = imgData.image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
//                            base64DataOrPath = "data:image/jpg;base64," + base64DataOrPath
//                        } else {
//                            base64DataOrPath = "image_holder_failed.png"
//                        }
//
//                        runInMain {
//                            self.reloadImage(webview, url: img, path: base64DataOrPath)
//                        }
//                    }
//                }
//            }
//        }
        
        private func reloadImage(_ webview: WKWebView, url: String, path: String) {
            let url = url.urlEncoded()
            let jsReloadFunction = "reloadImg('\(url)', '\(path)')"
            webview.evaluateJavaScript(jsReloadFunction) { (response, error) in
                if let error = error {
                    print("Error calling javascriptFunction: \(error)")
                }
            }
        }

        private func injectImgClicker(_ webview: WKWebView) {
            let javascriptFunction = "addClickToImg()"
            webview.evaluateJavaScript(javascriptFunction) { (response, error) in
                if let error = error {
                    print("Error calling javascriptFunction: \(error)")
                }
            }
        }

        private func measureHeightOfHtml(_ webview: WKWebView) {
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                webview.evaluateJavaScript("window.imgLoaded") { (imgLoaded, error) in
                    guard imgLoaded as! Bool else {
                        return
                    }
                    
                    timer.invalidate()
                                        
                    webview.evaluateJavaScript("document.documentElement.scrollHeight") { (height, error) in
                        DispatchQueue.main.async {
                            self.parent.height = height as! CGFloat
                        }
                    }
                }
            }
            
            webview.evaluateJavaScript("document.documentElement.scrollHeight") { (height, error) in
                DispatchQueue.main.async {
                    self.parent.height = height as! CGFloat
                    runInMain(delay: 100) {
//                        withAnimation {
                            self.parent.rendered = true
//                        }
                    }
                }
            }
            
        }
    }
}
