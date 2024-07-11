//
//  HTMLText.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/11/24.
//

import SwiftUI

struct HTMLText: View {
    let htmlString: String?
    
    var body: some View {
        getAttributedString(htmlString: htmlString).map { attributedString in
            Text(attributedString)
        }
    }
    
    private func getAttributedString(htmlString: String?) -> AttributedString? {
        if let data = htmlString?.data(using: .utf16) {
            if let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                
                if let formattedString = try? AttributedString(attributedString, including: \.uiKit) {
                    return formattedString
                }
            }
        }
        return nil
    }
}
