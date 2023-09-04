//
//  NewsCoordinator.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation

import UIKit
protocol NewsCoordinatorNavigaitons: AnyObject {
    func goToNeswDetails(article: Articles) 
    
}
class NewsCoordinator: BaseCoordinator {
    var navigationController :UINavigationController?
    init(navigationController: UINavigationController, presentingStyle:
         PresentingStyle) {
        super.init(navigation: navigationController, presentingStyle: presentingStyle)
        self.navigationController = navigationController
        
    }
    override func start(parentCoordinator: Coordinator) {
        let controller = NewsViewController()
        let viewModel = NewsViewModel()
        controller.viewModel = viewModel
        controller.coordinator = self
        presentingStyle(viewController: controller)
    }
}

extension NewsCoordinator: NewsCoordinatorNavigaitons{
    func goToNeswDetails(article: Articles) {
        let newsDateilsCoordinator = NewsDateilsCoordinator(navigationController: navigationController, presentingStyle: .push)
        childCoordinators.append(newsDateilsCoordinator)
        newsDateilsCoordinator.selectedArticle = article
        newsDateilsCoordinator.start(parentCoordinator: self)
    }
}
