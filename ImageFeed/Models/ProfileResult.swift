//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Irina Gubina on 05.06.2025.
//

import Foundation

struct ProfileResult: Decodable {
    let username: String
    let firstName: String?
    let lastName: String?
    let bio: String?
}
