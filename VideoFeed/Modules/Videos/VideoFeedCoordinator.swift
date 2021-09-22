//
//  VideosCoordinator.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 19/09/21.
//

import UIKit

protocol VideoFeedCoordinatorVMDelegate: AnyObject {
    func navigateToPlayer()
}

class VideoFeedCoordinator {
    let navigationController: UINavigationController
    var childCoordinator: CoordinatorProtocol?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - CoordinatorProtocol
extension VideoFeedCoordinator: CoordinatorProtocol {
    func start() {
        let videoFeedVC = VideoFeedVC.create()
        let viewModel = VideoFeedVM()
        viewModel.coordinatorDelegate = self
        videoFeedVC.viewModel = viewModel
        navigationController.pushViewController(videoFeedVC, animated: false)
    }
}

// MARK: - VideosCoordinatorViewModelDelegate
extension VideoFeedCoordinator: VideoFeedCoordinatorVMDelegate {
    func navigateToPlayer() {
    }
}
