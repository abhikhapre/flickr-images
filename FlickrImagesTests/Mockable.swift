//
//  Mockable.swift
//  FlickrImagesTests
//
//  Created by Abhishek Khapare on 7/10/24.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)
            
            return decodedObject
        } catch {
            fatalError("Failed to load JSON")
        }
    }
}
