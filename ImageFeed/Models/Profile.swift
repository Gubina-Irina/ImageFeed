//
//  ProdileData.swift
//  ImageFeed
//
//  Created by Irina Gubina on 11.05.2025.
//

import Foundation

struct Profile {
    var userName: String
    var name: String
    var loginName: String
    var bio: String?
    
    init(profileResult: ProfileResult){
        self.userName = profileResult.username
        self.loginName = "@\(profileResult.username)"
        
        var fullName = [String]()
        if let firsName = profileResult.firstName {
            fullName.append(firsName)
        }
        if let lastName = profileResult.lastName {
            fullName.append(lastName)
        }
        
        self.name = fullName.joined(separator: " ")
        
        self.bio = profileResult.bio
    }
}
