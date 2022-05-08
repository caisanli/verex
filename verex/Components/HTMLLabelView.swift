//
//  HTMLLabelView.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/8.
//

import Foundation
import SwiftUI

struct HTMLLabelView: UIViewRepresentable {
    
    var htmlContent: String
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel();
        do {
            if let data = htmlContent.data(using: String.Encoding.unicode, allowLossyConversion: true) {
                let attStr = try NSAttributedString.init(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html,], documentAttributes: nil)
                label.attributedText = attStr
            }
        } catch {
            label.text = htmlContent
        }
        return label
    }
    
    func updateUIView(_ label: UILabel, context: Context) {

    }
    
}
