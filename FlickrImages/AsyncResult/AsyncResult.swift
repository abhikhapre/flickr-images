//
//  AsyncResult.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

// AsyncResult represents the state of an asynchronous task and its result.
public enum AsyncResult {
    case empty
    case inProgress
    case success
    case failure(Error)
}
