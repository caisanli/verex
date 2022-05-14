//
//  RichText.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/13.
//

import Foundation
import UIKit
import SwiftUI
import Atributika

typealias RichString = Atributika.AttributedText

struct RichText: View {
    typealias DetectionAction = (DetectionType) -> Bool
    let action: DetectionAction?
    let richString: NSAttributedString
    @State var height: CGFloat = 0
    
    init(_ string: () -> String, action: DetectionAction? = nil) {
        self.init({ string().rich() }, action: action)
    }
    
    init(_ richString: () -> NSAttributedString, action: DetectionAction? = nil) {
        self.richString = richString()
        self.action = action
    }
    
    var body: some View {
        GeometryReader { geo in
            AttributedText(richString, detection: action, maxWidth: geo.size.width, height: $height)
        }
        .frame(height: height)
    }
    
    struct Styles {
        public static let base = Style.font(.systemFont(ofSize: 14, weight: .regular))
            .foregroundColor(UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0))
        
        public static let link = Style("a")
            .font(.systemFont(ofSize: 14, weight: .regular))
            .foregroundColor(.blue)
            .backgroundColor(.gray, .highlighted)
    }
}


fileprivate struct AttributedText: UIViewRepresentable {
    let richString: NSAttributedString
    let detection: RichText.DetectionAction?
    var maxWidth: CGFloat
    @Binding var height: CGFloat
    
    init(_ richString: NSAttributedString, detection: RichText.DetectionAction?, maxWidth: CGFloat, height: Binding<CGFloat>) {
        self.detection = detection
        self.richString = richString
        self.maxWidth = maxWidth
        self._height = height
    }
    
    func makeUIView(context: Context) -> MaxWidthAttributedLabel {
    
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.paragraphSpacing = 10
        paragraphStyle.lineBreakMode = .byCharWrapping
        let attrString = NSMutableAttributedString(attributedString: self.richString)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        let label = MaxWidthAttributedLabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.attributedText = attrString
        label.isUserInteractionEnabled = true
        label.maxWidth = maxWidth
        clickEvent(label: label)
        return label
    }
    
    func updateUIView(_ label: MaxWidthAttributedLabel, context: Context) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.paragraphSpacing = 10
        paragraphStyle.lineBreakMode = .byCharWrapping
        let attrString = NSMutableAttributedString(attributedString: self.richString)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
        label.maxWidth = maxWidth
        runInMain(delay: 100) {
            self.height = label.sizeThatFits(CGSize(width: maxWidth, height: .infinity)).height
        }
    }
    
    private func clickEvent(label: MaxWidthAttributedLabel) {
        let guestureRecognizer = UITapGestureRecognizer(target: label, action: #selector(label.onClickLabel))
        label.addGestureRecognizer(guestureRecognizer)
    }
        
    func runInMain(delay: Int = 0, execute work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(delay), execute: work)
    }
    
}

fileprivate class MaxWidthAttributedLabel: UILabel {
    var maxWidth: CGFloat!
    
    open override var intrinsicContentSize: CGSize {
        sizeThatFits(CGSize(width: maxWidth, height: .infinity))
    }
    
    @objc func onClickLabel(tapGestureRecognizer: UITapGestureRecognizer) {
//        tapGestureRecognizer.
        print(tapGestureRecognizer)
    }
    
}

extension String {
    func rich(baseStyle: Atributika.Style = RichText.Styles.base) -> NSAttributedString {
        return self.style(tags: RichText.Styles.link)
            .styleLinks(RichText.Styles.link)
            .styleMentions(RichText.Styles.link)
            .styleAll(baseStyle)
            .attributedString
    }
}
