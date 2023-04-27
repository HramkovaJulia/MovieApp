//
//  DetailsRouter.swift
//  MoviewCollectionApp
//
//  Created by Julia on 24.04.2023.
//

import Foundation
import UIKit

protocol DetailsRouterInput {
    func openActorModule(with actorId: Int)
}

final class DetailsRouter: DetailsRouterInput {
    weak var viewController: UIViewController?

    func openActorModule(with actorId: Int) {
        let actorVC = CastModuleAssembly().assemble { presenter in
            presenter.configure(with: actorId)
        }
        print(actorId)
        viewController?.navigationController?.pushViewController(actorVC, animated: true)
    }
}
