//
//  MoviesInteractor.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import Foundation

protocol MoviesInteractorInput {
    func obtainMovies()
}

protocol MoviesInteractorOutput: AnyObject {
    func didLoadTrendingMovies(_ movies: [Movie])
    func didLoadTodayMovies(_ movies: [Movie])
    func didLoadSoonMovies(_ movies: [Movie])
    func didLoadGenres(_ genres: [Genre])
}

final class MoviesInteractor: MoviesInteractorInput {
    
    private var network = AlamofireNetworkService.shared
    
    weak var output: MoviesInteractorOutput!
    
    required init(network: AlamofireNetworkService) {
        self.network = network
    }
    
    func obtainMovies() {
        network.loadMovieListTrending { [weak self] movies in
            self?.output.didLoadTrendingMovies(movies)
        }
        network.loadMovieListToday { [weak self] movies in
            self?.output.didLoadTodayMovies(movies)
        }
        network.loadMovieListSoon { [weak self] movies in
            self?.output.didLoadSoonMovies(movies)
        }
        network.loadGenres { [weak self] genres in
            self?.output.didLoadGenres(genres)
        }
    }
}
