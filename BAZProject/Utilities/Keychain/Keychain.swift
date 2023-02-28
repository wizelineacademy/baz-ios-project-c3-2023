//
//  Keychain.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 23/02/23.
//

import Foundation
struct Auth: Codable {
    let accessToken: String
    let refreshToken: String
}

final class KeychainHelper {    
    private var apiKey: Auth = Auth(accessToken: "apiKey", refreshToken: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
    
    func getApiKey() -> Auth? {
        let account = "domain.com"
        let service = "token"
        KeychainHelper.shared.save(apiKey, service: service, account: account)
        return KeychainHelper.shared.read(service: service,
                                            account: account,
                                            type: Auth.self)!
    }
    
    
    
    static let shared = KeychainHelper()
    private init() {}
    
    private func save(_ data: Data, service: String, account: String) {

        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        if status != errSecSuccess {
            debugPrint("Error: \(status)")
        }
    }

    private func read(service: String, account: String) -> Data? {

        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return (result as? Data)
    }
    
    func delete(service: String, account: String) {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func save<T>(_ item: T, service: String, account: String) where T : Codable {
        
        do {
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
            
        } catch {
            debugPrint("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            debugPrint("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
}
