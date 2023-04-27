//
//  MovieDetailResponce.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 27.01.2023.
//

import Foundation

struct MovieDetailsResponse: Decodable {
  
    let backdropPath: String
    let id: Int
    let overview: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
}



