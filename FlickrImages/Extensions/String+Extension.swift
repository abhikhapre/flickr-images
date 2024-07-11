//
//  String+Extension.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

extension String {
    enum DateFormat {
        case monthDateYear
    }
    
    func formattedDate(_ dateFormat: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        
        var formattedDate: String?
        
        switch dateFormat {
        case .monthDateYear:
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: self) {
                
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "MM/dd/yyyy"
                
                formattedDate = outputDateFormatter.string(from: date)
            }
        }
        
        return formattedDate
    }
}


