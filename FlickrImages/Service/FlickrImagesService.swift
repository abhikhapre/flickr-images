//
//  FlickrImagesService.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

protocol FlickrImagesServiceable {
    func getFlickrImages(searchText: String) async -> Result<FlickrImagesServerDataModel, RequestError>
}

struct FlickrImagesService: HTTPClient, FlickrImagesServiceable {
    func getFlickrImages(searchText: String) async -> Result<FlickrImagesServerDataModel, RequestError> {
        await sendRequest(endpoint: FlickrEndpoint.flickrImages(searchText), responseModel: FlickrImagesServerDataModel.self)
    }
}
