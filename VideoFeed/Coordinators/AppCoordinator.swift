//
//  AppCoordinator.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 19/09/21.
//

import UIKit

protocol CoordinatorProtocol {
    func start()
}

final class AppCoordinator: CoordinatorProtocol {
    let window: UIWindow
    var coordinators: [CoordinatorProtocol] = []
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - CoordinatorProtocol
extension AppCoordinator {
    func start() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isOpaque = true
        tabBarController.viewControllers = []
        var rootViewControllers: [UIViewController] = []
        // Create video feed tab
        let videosNC = UINavigationController()
        videosNC.isNavigationBarHidden = true
        videosNC.tabBarItem = UITabBarItem(title: "Videos", image: UIImage(systemName: "home"), selectedImage: nil)
        let videosCoordinator = VideoFeedCoordinator(navigationController: videosNC)
        coordinators.append(videosCoordinator)
        videosCoordinator.start()
        rootViewControllers.append(videosNC)
        // Create profile tab
        let profileNC = UINavigationController()
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "user"), selectedImage: nil)
        let profileCoordinator = UserProfileCoordinator(navigationController: profileNC)
        coordinators.append(profileCoordinator)
        profileCoordinator.start()
        rootViewControllers.append(profileNC)
        // Add to tab controller
        tabBarController.setViewControllers(rootViewControllers, animated: false)
        window.rootViewController = tabBarController
    }
}
