//
//  JSONLoader.swift
//  Country
//
//  Created by Leonardo Modro on 30/08/23.
//

import Foundation

public class JSONLoader {
    public init() { }

    public func jsonData(fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            throw JSONLoaderError.failedToLoadJSONFile(name: fileName)
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
    
    public func load<T: Decodable>(_ jsonFileName: JSONFile) throws -> T? {
        return try load(fileName: jsonFileName.rawValue)
    }
    
    private func load<T: Decodable>(fileName: String, jsonDecoder: JSONDecoder = JSONDecoder()) throws -> T? {
        let data = try jsonData(fileName: fileName)
                
        return try jsonDecoder.decode(T.self, from: data)
    }
}

// MARK: Enums
public enum JSONLoaderError: Error {
    case failedToLoadJSONFile(name: String)
}

public enum JSONFile: String {
    case countries
}
