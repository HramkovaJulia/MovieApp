//
//  MoviesRouter.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import Foundation
import UIKit

protocol MoviesRouterInput {
    func openMovieModule(with movieId: Int)
}

final class MoviesRouter: MoviesRouterInput {

    weak var viewController: UIViewController?

    func openMovieModule(with movieId: Int) {
        let detailsVC = DetailsModuleAssembly().assemble { presenter in
            presenter.configure(with: movieId)
        }
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
