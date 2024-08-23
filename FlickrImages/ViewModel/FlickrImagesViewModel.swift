//
//  FlickrImagesViewModel.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

class FlickrImagesViewModel: ObservableObject {
    private let service: FlickrImagesServiceable
    
    @Published var flickrImagesDataResult: AsyncResult = .empty
    @Published var flickrImagesDataModel: FlickrImagesServerDataModel?
    
    var placeholderText: String { "Search for Flickr Images" }
    var navigationTitle: String { "Flickr Images" }
    var apiFailureError: String { "Error fetching Images. Please try again." }
    
    init(service: FlickrImagesServiceable = FlickrImagesService()) {
        self.service = service
    }
}

// MARK: - N/W call
extension FlickrImagesViewModel {
    @MainActor
    func getImages(searchText: String) async {
        guard searchText.count > 0 else {
            flickrImagesDataResult = .empty
            clearData()
            return
        }
        
        flickrImagesDataResult = .inProgress
        let resultData = await service.getFlickrImages(searchText: searchText)
        
        switch resultData {
        case .success(let model):
            flickrImagesDataModel = model
            flickrImagesDataResult = .success
        case .failure(let error):
            flickrImagesDataModel = nil
            flickrImagesDataResult = .failure(error)
        }
    }
}

// MARK: - Helper methods
extension FlickrImagesViewModel {
    func getImageURL(_ imageItem: FlickrImagesServerDataModel.FlickrImageItem) -> URL? {
        guard let imageURLString = imageItem.media?.imageURL else { return nil }
        
        return URL(string: imageURLString)
    }
    
    func getFormattedDate(_ dateString: String?) -> String? {
        dateString?.formattedDate(.monthDateYear)
    }
}

// MARK: - Private mehtods
extension FlickrImagesViewModel {
    private func clearData() {
        if flickrImagesDataModel != nil {
            flickrImagesDataModel = nil
        }
    }
}
