//
//  GenresEntity.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 20.01.2023.
//

import Foundation

struct Genre: Codable{
    let id: Int
    let name: String
}

struct GenresEntity: Codable{
    let genres: [Genre]
}
