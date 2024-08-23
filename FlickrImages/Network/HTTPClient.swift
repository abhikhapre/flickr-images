//
//  HTTPClient.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var httpResponse: URLResponse?
        var responseData: Data?
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            responseData = data
            httpResponse = response
        } catch {
            return .failure(.systemError(detail: error.localizedDescription))
        }
        
        guard (httpResponse as? HTTPURLResponse)?.statusCode == 200 else {
            // log error here
            print(RequestError.noResponse.localizedDescription)
            return .failure(.noResponse)
        }
        
        do {
            guard let data = responseData else {
                return .failure(.missingData)
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
            
        } catch  {
            return .failure(.decode)
        }
    }
}
