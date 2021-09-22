//
//  ProfileCoordinator.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 19/09/21.
//

import UIKit

class UserProfileCoordinator {
    let navigationController: UINavigationController
    var childCoordinator: CoordinatorProtocol?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - CoordinatorProtocol
extension UserProfileCoordinator: CoordinatorProtocol {
    func start() {
        let userProfileVC = UserProfileVC.create()
        let viewModel = UserProfileVM()
        userProfileVC.viewModel = viewModel
        navigationController.pushViewController(userProfileVC, animated: false)
    }
}
