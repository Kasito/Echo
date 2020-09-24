//
//  KeyChain.swift
//  Echo
//
//  Created by Kasito on 23.09.2020.
//

import Foundation
import Security

class KeychainService {
    
    static func save(_ password: String, serviceKey: String) {
        guard let dataFromString = password.data(using: .utf8) else { return }
        
        let keychainQuery: [CFString : Any] = [kSecClass: kSecClassGenericPassword,
                                               kSecAttrService: serviceKey,
                                               kSecValueData: dataFromString]
        SecItemDelete(keychainQuery as CFDictionary)
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    static func load(serviceKey: String) -> String? {
        let keychainQuery: [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                               kSecAttrService : serviceKey,
                                               kSecReturnData: kCFBooleanTrue as Any,
                                               kSecMatchLimitOne: kSecMatchLimitOne]
        
        var dataTypeRef: AnyObject?
        SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
        guard let retrievedData = dataTypeRef as? Data else { return nil }
        
        return String(data: retrievedData, encoding: .utf8)
    }
}
