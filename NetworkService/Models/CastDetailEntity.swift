//
//  CastDetailEntity.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 02.02.2023.
//

import Foundation

struct CastDetailEntity: Decodable {
  
    let profilePath: String?
    let id: Int
    let birthday: String
    let knownForDepartment: String?
    let biography: String?
    let name: String
    let placeOfBirth: String?
}
