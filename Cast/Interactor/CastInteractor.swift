//
//  CastInteractor.swift
//  MoviewCollectionApp
//
//  Created by Julia on 27.04.2023.
//

import Foundation

protocol CastInteractorInput: AnyObject {
    func obtainActor(with actorId: Int)
}

protocol CastInteractorOutput: AnyObject {
    func didLoadActor(_ actor: [CastDetailEntity])
}

final class CastInteractor: CastInteractorInput {

    weak var output: CastInteractorOutput!
    private var network: AlamofireNetworkService!

    required init(network: AlamofireNetworkService) {
        self.network = network
    }

    func obtainActor(with actorId: Int) {
        network.loadCastDetails(with: actorId) { [weak self] actor in
            self?.output.didLoadActor(actor)
        }
    }
}
