//
//  FlickrImagesServerDataModel.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

struct FlickrImagesServerDataModel: Decodable {
    let title: String?
    let link: String?
    let description: String?
    let modified: String?
    let generator: String?
    let items: [FlickrImageItem]?
    
    struct FlickrImageItem: Decodable {
        let title: String?
        let link: String?
        let media: Media?
        let description: String?
        let published: String?
        let author: String?
        var abc: String?
    }
    
    struct Media: Decodable {
        let imageURL: String?
        
        enum CodingKeys: String, CodingKey {
            case imageURL = "m"
        }
    }
}
