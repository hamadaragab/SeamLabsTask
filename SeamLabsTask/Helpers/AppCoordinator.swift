//
//  AppCoordinator.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import UIKit
class AppCoordinator{
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController = UINavigationController()
    private var window: UIWindow?
    init(window: UIWindow? = nil) {
        self.window = window
    }
    func start() {
        let coordinator = NewsCoordinator(navigationController: navigationController, presentingStyle: .push)
        childCoordinators.append(coordinator)
        coordinator.start(parentCoordinator: BaseCoordinator(navigation: navigationController, presentingStyle: .push))
//        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
    
    
}
