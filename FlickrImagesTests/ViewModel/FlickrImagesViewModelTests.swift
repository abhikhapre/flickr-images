//
//  FlickrImagesViewModelTests.swift
//  FlickrImagesTests
//
//  Created by Abhishek Khapare on 7/10/24.
//

import XCTest

final class FlickrImagesViewModelTests: XCTestCase {
    private var viewModel: FlickrImagesViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let mockService = FlickrImagesServiceMock()
        viewModel = FlickrImagesViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testGetImages() async {
        let expectation = XCTestExpectation(description: "view_model_test")
        
        await viewModel.getImages(searchText: "porcupine")
        
        XCTAssertNotNil(viewModel.flickrImagesDataModel)
        XCTAssertEqual(viewModel.flickrImagesDataModel?.title, "Recent Uploads tagged porcupine")
        XCTAssertEqual(viewModel.flickrImagesDataModel?.items?.count, 20)
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func testGetFormattedDate() {
        XCTAssertEqual(viewModel.getFormattedDate("2024-07-10T02:23:05Z"), "07/09/2024")
        XCTAssertNil(viewModel.getFormattedDate("123456"))
    }
}
