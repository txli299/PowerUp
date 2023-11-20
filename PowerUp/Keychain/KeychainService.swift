//
//  KeychainService.swift
//  PowerUp
//
//  Created by Hank Gu on 11/12/23.
//

import Foundation
import SwiftKeychainWrapper

class KeychainService {
    static let tokenKey = "authToken"

    static func saveToken(_ token: String) {
        let saved = KeychainWrapper.standard.set(token, forKey: tokenKey)
        if !saved {
            print("Failed to save token to keychain")
        }
    }

    static func loadToken() -> String? {
        let token = KeychainWrapper.standard.string(forKey: tokenKey)
        return token
    }

    static func deleteToken() {
        let removed = KeychainWrapper.standard.removeObject(forKey: tokenKey)
        if !removed {
            print("Failed to remove token from keychain")
        }
    }
}
