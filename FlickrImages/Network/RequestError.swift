//
//  RequestError.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

enum RequestError: LocalizedError {
   
    /// wrong url
    case invalidURL
    
    /// API Response has no data attached
    case missingData
    
    /// Generic errors I can't think of
    case systemError(detail: String)
    
    /// decoding errors without description
    case decode
    
    /// decoding related errors
    case decodingError(error: DecodingError)

    /// resquest has no httpresponse
    case noResponse
    
    /// unkown errors
    case unknown
    
    /// for all http status errors
    case responseStatusError(status: Int, message: String)
}


extension RequestError {
    public var errorDescription: String? {
        switch self {
        case .decode:
            return "Decoding error no description provided"
        case .decodingError(let detail):
            return "Decoding error: \(detail.localizedDescription)"
        case .invalidURL:
            return "Invalid URL"
        case .missingData:
            return "API Response has no data attached"
        case .unknown:
            return "Unknown error"
        case .responseStatusError(let statusCode, let message):
            return "API Response Failure: \(statusCode): \(message)"
        case .systemError(let detail):
            return "System error with description = \(detail)"
        case .noResponse:
            return "HTTP response is missing"
        }
    }
}
