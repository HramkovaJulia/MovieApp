//
//  DetailsPresenter.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import Foundation

final class DetailsPresenter: DetailsViewOutput, DetailsInteractorOutput, DetailsModuleInput  {
   
    weak var view: DetailsViewInput!
    var router: DetailsRouterInput!
    var interactor: DetailsInteractorInput!
    private var movieId: Int!

    
    func didLoadDetails(_ details: [MovieDetailsResponse]) {
        view.handObtainedDetails(details)
    }
    
    func configure(with movieId: Int) {
        self.movieId = movieId
    }

    func didLoadView() {
        interactor.obtainDetails(with: movieId)
        interactor.obtainCasts(with: movieId)
    }

    func didLoadCasts(_ casts: [Actors]) {
        view.handObtainedCasts(casts)
    }

    func didSelectCell(with actorId: Int) {
        router.openActorModule(with: actorId)
    }
}
