//
//  FlickrImagesServiceTests.swift
//  FlickrImagesTests
//
//  Created by Abhishek Khapare on 7/10/24.
//

import XCTest

final class FlickrImagesServiceTests: XCTestCase {
    private var serviceMock: FlickrImagesServiceMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        serviceMock = FlickrImagesServiceMock()
    }

    override func tearDownWithError() throws {
        serviceMock = nil
        
        try super.tearDownWithError()
    }

    func testGetImagesSuccessResponse() async {
        let expectation = XCTestExpectation(description: "mock_service")
        let successResult = await serviceMock.getFlickrImages(searchText: "porcupine")
        
        switch successResult {
        case .success(let model):
            XCTAssertNotNil(model)
            XCTAssertEqual(model.title, "Recent Uploads tagged porcupine")
            XCTAssertEqual(model.items?.count, 20)
        case .failure:
            XCTFail("The request should not fail")
        }
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testGetImagesFailureResponse() async {
        let expectation = XCTestExpectation(description: "mock_service")
        serviceMock = FlickrImagesServiceMock(resource: "invalid_path")
        let failureResult = await serviceMock.getFlickrImages(searchText: "porcupine")
        
        switch failureResult {
        case .success:
            XCTFail("The request should fail")
        case .failure(let error):
            
            XCTAssertEqual(error.errorDescription, "Invalid URL")
        }
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 1)
    }
}
