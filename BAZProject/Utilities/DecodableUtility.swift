//
//  DecodableUtility.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import Foundation

public final class DecodeUtility {
    /**
     func to help to decode data

     - Parameter decodable: struct to decode
     - Parameter from: data that want decode

     - Returns: decoded data

     - Important: This code can return a nil.
     */
    static public func decode<T: Decodable>(_ decodable: T.Type, from data: Data) -> T? where T: Decodable {
        var decodedData: T?
        do {
            decodedData = try JSONDecoder().decode(T.self, from: data)
        } catch DecodingError.dataCorrupted( _) {
            debugPrint( "Data is corrupted")
        } catch DecodingError.keyNotFound( _, let context) {
            debugPrint("Key not found:", context.debugDescription)
            debugPrint( "codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound( _, let context) {
            debugPrint("Value not found:", context.debugDescription)
            debugPrint("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch( _, let context) {
            debugPrint("Type mismatch:", context.debugDescription)
            debugPrint("codingPath:", context.codingPath)
        } catch {
            debugPrint( "error: ", error as CVarArg)
        }
        return decodedData
    }
}
