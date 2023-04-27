//
//  CastPresenter.swift
//  MoviewCollectionApp
//
//  Created by Julia on 27.04.2023.
//

import Foundation

final class CastPresenter: CastViewOutput, CastInteractorOutput, CastModuleInput {
   
    func didLoadActor(_ actor: [CastDetailEntity]) {
        view?.handleObtainedActor(actor)
    }

    var interactor: CastInteractorInput!
    var router: CastRouter!
    
    weak var view: CastViewInput?
    private var actorId: Int!

    required init(view: CastViewInput? = nil) {
        self.view = view
    }

    func configure(with actorId: Int) {
        self.actorId = actorId
    }

    func didLoadView() {
        interactor.obtainActor(with: actorId)
    }
}
