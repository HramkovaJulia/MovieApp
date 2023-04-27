//
//  DetailsModuleAssembly.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import UIKit

protocol DetailsModuleInput {
    func configure(with movieId: Int)
}

typealias DetailsModuleConfiguration = (DetailsModuleInput) -> Void

final class DetailsModuleAssembly {
    func assemble(_ configuration: DetailsModuleConfiguration? = nil) -> MovieDetailsViewController {
        let detailsVC = MovieDetailsViewController()
        let presenter = DetailsPresenter()
        let network = AlamofireNetworkService.shared
        let interactor = DetailsInteractor(network: network)
        let router = DetailsRouter()

        configuration?(presenter)

        detailsVC.output = presenter

        presenter.view = detailsVC
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter

        router.viewController = detailsVC

        return detailsVC
    }
}
