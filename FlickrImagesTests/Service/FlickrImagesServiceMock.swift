//
//  FlickrImagesServiceMock.swift
//  FlickrImagesTests
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

final class FlickrImagesServiceMock: Mockable, FlickrImagesServiceable {
    private var resource: String
    
    init(resource: String = "flickr_images_mock_data") {
        self.resource = resource
    }
    
    func getFlickrImages(searchText: String) async -> Result<FlickrImagesServerDataModel, RequestError> {
        if resource == "flickr_images_mock_data" {
            return .success(loadJSON(fileName: resource, type: FlickrImagesServerDataModel.self))
        } else {
            return .failure(.invalidURL)
        }
    }
}
