//
//  CastEntity.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 01.02.2023.
//

import Foundation

struct Actors: Decodable {
    enum CodingKeys: String, CodingKey{
        case id
        case name = "name"
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
       
    }
    
    let id: Int
    let name: String?
    let knownForDepartment: String?
    let profilePath: String?
}

struct CastEntity: Decodable {
    let cast: [Actors]
}
