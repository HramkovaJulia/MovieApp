//
//  MoviesModuleAssembly.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import Foundation
import UIKit

final class MovieModuleAssembly {

    func assemble() -> HomeViewController {
        let movieVC = HomeViewController()
        let presenter = MoviesPresenter()
        let network = AlamofireNetworkService.shared
        let interactor = MoviesInteractor(network: network)
        let router = MoviesRouter()

        movieVC.output = presenter

        presenter.view = movieVC 
        presenter.interactor = interactor
        presenter.router = router as! any MoviesRouterInput

        interactor.output = presenter

        router.viewController = movieVC

        return movieVC
    }
}

