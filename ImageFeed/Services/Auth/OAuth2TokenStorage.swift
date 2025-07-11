//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Irina Gubina on 28.05.2025.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    let tokenKey = "accessToken"
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: tokenKey)
        }
        set {
            if let newValue = newValue {
                let isSuccess = KeychainWrapper.standard.set(newValue, forKey: tokenKey)
                if !isSuccess {
                    assertionFailure(("❌ Failed to save token in Keychain"))
                }
            } else {
                let isSucceess = KeychainWrapper.standard.removeObject(forKey: tokenKey)
                if !isSucceess {
                    assertionFailure("❌ Failed to delete token in Keychain")
                }
            }
        }
    }
    
    func deleteOAuth2Token() {
        token = nil
    }
}
