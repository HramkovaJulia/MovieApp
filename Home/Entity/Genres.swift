//
//  Genres.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import Foundation

struct Genre: Codable{
    let id: Int
    let name: String
}

struct GenresEntity: Codable{
    let genres: [Genre]
}
