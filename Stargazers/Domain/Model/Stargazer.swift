//
//  Stargazer.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

struct Stargazer {
    
    // The time the star was created
    var starredAt: String
    // User username
    var username: String
    // User avatar url as String
    var avatarUrl: String
    
    init() {
        starredAt = ""
        username = ""
        avatarUrl = ""
    }
}
