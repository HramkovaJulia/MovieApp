//
//  CastModuleBuilder.swift
//  MoviewCollectionApp
//
//  Created by Julia on 27.04.2023.
//

import Foundation

protocol CastModuleInput {
    func configure(with actorId: Int)
}

typealias CastModuleConfiguration = (CastModuleInput) -> Void

final class CastModuleAssembly {
    func assemble(_ configuration: CastModuleConfiguration? = nil) -> CastMemberViewController {
        let actorVC = CastMemberViewController()
        let presenter = CastPresenter()
        let network = AlamofireNetworkService.shared
        let interactor = CastInteractor(network: network)
        let router = CastRouter()

        configuration?(presenter)
        
        actorVC.output = presenter

        presenter.view = actorVC
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.viewController = actorVC

        return actorVC
    }
}
