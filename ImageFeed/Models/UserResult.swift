//
//  UserResult.swift
//  ImageFeed
//
//  Created by Irina Gubina on 09.06.2025.
//

import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImage
    
    struct ProfileImage: Codable {
        let small: String
    }
}
