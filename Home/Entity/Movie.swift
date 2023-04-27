//
//  Movie.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import Foundation

struct Movie: Decodable {
    enum CodingKeys: String, CodingKey{
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case genderIds = "genre_ids"
    }
    let id: Int
    let originalTitle: String?
    let releaseDate: String?
    let voteAverage: Double
    let posterPath: String?
    let genderIds: [Int]
}

struct MoviesEntity: Decodable {
    let results: [Movie]
}
