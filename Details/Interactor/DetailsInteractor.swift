//
//  DetailsInteractor.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import Foundation

protocol DetailsInteractorInput: AnyObject {
    func obtainDetails(with movieId: Int)
    func obtainCasts(with movieId: Int)
}

protocol DetailsInteractorOutput: AnyObject {
    func didLoadDetails(_ details: [MovieDetailsResponse])
    func didLoadCasts(_ casts: [Actors])
}

final class DetailsInteractor: DetailsInteractorInput {

    weak var output: DetailsInteractorOutput!

    private var network = AlamofireNetworkService.shared
    
   required init(network: AlamofireNetworkService) {
        self.network = network
    }

    func obtainDetails(with movieId: Int) {
        network.getMovieDetails(with: movieId) { [weak self] details in
            self?.output.didLoadDetails(details)
        }
    }

    func obtainCasts(with movieId: Int) {
        network.getMovieCredits(with: movieId) { [weak self] casts in
            self?.output.didLoadCasts(casts)
        }
    }
}
