//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Irina Gubina on 28.05.2025.
//

import Foundation

final class OAuth2TokenStorage {
    private let tokenKey = "accessToken"
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
}
