//
//  NewsDateilsCoordinator.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation

import UIKit
protocol NewsDateilsCoordinatorNavigaitons: AnyObject {

}
class NewsDateilsCoordinator: BaseCoordinator {
    var navigationController :UINavigationController?
    var selectedArticle: Articles?
    init(navigationController: UINavigationController?, presentingStyle:
         PresentingStyle) {
        super.init(navigation: navigationController, presentingStyle: presentingStyle)
        self.navigationController = navigationController
        
    }
    override func start(parentCoordinator: Coordinator) {
        let controller = NeswDetailsViewController()
        let viewModel = NeswDetailsViewModel(selectedArticle: selectedArticle)
        controller.viewModel = viewModel
        controller.coordinator = self
        presentingStyle(viewController: controller)
    }
}

extension NewsDateilsCoordinator: NewsDateilsCoordinatorNavigaitons{
  
}
