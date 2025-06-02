//
//  Constants.swift
//  ImageFeed
//
//  Created by Irina Gubina on 15.05.2025.
//

import Foundation

enum Constants {
    static let accessKey = "JTDJj5tncThoWcUil3pqq54xC2ViY5Wzw3VJBWSUhI0"
    static let secretKey = "J-xxba2jU9z3VoosWvW-XTwKMO53-oswHwYSd-Jw6ZY"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL: URL = {
        guard let url = URL(string: "https://api.unsplash.com") else {
            fatalError("Invalid base URL")
        }
        return url
    }()
}
