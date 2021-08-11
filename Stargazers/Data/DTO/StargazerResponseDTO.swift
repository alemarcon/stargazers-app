//
//  StargazerResponseDTO.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

struct StargazerResponseDTO: Codable, Equatable {
    
    let starredAt: String?
    let user: UserResponseDTO?

    enum CodingKeys: String, CodingKey {
        case starredAt = "starred_at"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        starredAt = try values.decodeIfPresent(String.self, forKey: .starredAt)
        user = try values.decodeIfPresent(UserResponseDTO.self, forKey: .user)
    }
}
