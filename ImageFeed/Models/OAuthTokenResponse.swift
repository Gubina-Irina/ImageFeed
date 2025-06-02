//
//  OAuthTokenResponse.swift
//  ImageFeed
//
//  Created by Irina Gubina on 28.05.2025.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}


