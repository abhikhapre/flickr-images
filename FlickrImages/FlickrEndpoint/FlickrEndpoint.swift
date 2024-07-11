//
//  FlickrEndpoint.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

enum FlickrEndpoint {
    case flickrImages(String)
}

extension FlickrEndpoint: Endpoint {
    var host: String { "api.flickr.com" }
    
    var path: String {
        switch self {
        case .flickrImages:
            return "/services/feeds/photos_public.gne"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .flickrImages(let searchText):
            return [
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
                URLQueryItem(name: "tags", value: searchText)
            ]
        }
    }
}
