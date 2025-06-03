//
//  OAuthTokenResponse.swift
//  ImageFeed
//
//  Created by Irina Gubina on 28.05.2025.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}


