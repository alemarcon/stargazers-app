//
//  StargazerDTOMapper.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

class StargazerDTOMapper {
    
    /// Map StargazerResponseDTO object to Stargazer entity object
    /// - Parameter dto: StargazerResponseDTO object to map
    /// - Returns: Stargazer object mapped with DTO data
    static func toEntity(dto: StargazerResponseDTO) -> Stargazer {
        var stargazer = Stargazer()
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
        
        if let data = dto.starredAt {
            if let date = dateFormatter.date(from: data) {
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                stargazer.starredAt = dateFormatter.string(from: date)
            }
        }
        
        if let user = dto.user {
            stargazer.username = user.login ?? "-"
            stargazer.avatarUrl = user.avatarUrl ?? ""
        }
        
        return stargazer
    }
    
    /// Map StargazerResponseDTO object array to Stargazer entity object array
    /// - Parameter dtos: StargazerResponseDTO object array to map
    /// - Returns: Stargazer object array mapped with DTO array data
    static func toEntityArray(dtos: [StargazerResponseDTO]) -> [Stargazer] {
        var stargazers = [Stargazer]()
        
        for dto in dtos {
            stargazers.append(toEntity(dto: dto))
        }
        
        return stargazers
    }

}
