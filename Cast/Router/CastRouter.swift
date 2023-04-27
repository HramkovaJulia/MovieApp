//
//  CastRouter.swift
//  MoviewCollectionApp
//
//  Created by Julia on 27.04.2023.
//

import Foundation
import UIKit

protocol CastRouterInput {
    func openActorModule(with movieId: Int)
}

final class CastRouter {
    weak var viewController: UIViewController?

    func openActorModule(with actorId: Int) {
        let actorVC = CastModuleAssembly().assemble { (actorInput: CastModuleInput) in
            actorInput.configure(with: actorId)
        }
        viewController?.navigationController?.pushViewController(actorVC, animated: true)
    }
}
