//
//  Coordinator.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
import UIKit
protocol Coordinator: AnyObject {
    var  childCoordinators: [Coordinator] {get}
    func start(parentCoordinator: Coordinator)
    var  parent_Coordinator: Coordinator? { get set }
    func presentingStyle(viewController: UIViewController)
    func dismiss(dismissingStyle :DismissingStyle)
    func didFinish(dismissingStyle :DismissingStyle,coordindtor: Coordinator)
    func popToViewController(viewController: AnyClass)
}


class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parent_Coordinator: Coordinator?
    var naviagtion : UINavigationController?
    var presentingStyle: PresentingStyle? = .push
    init(navigation: UINavigationController?, presentingStyle: PresentingStyle) {
        self.naviagtion = navigation
        self.presentingStyle = presentingStyle
    }
    func start(parentCoordinator: Coordinator) {
        print("shshshshhsshh")
    }
    func presentingStyle(viewController: UIViewController) {
        switch presentingStyle {
        case .push:
            self.naviagtion?.pushViewController(viewController, animated: true)
        case .Present:
//            viewController.modalPresentationStyle = .fullScreen
            self.naviagtion?.present(viewController, animated: true)
        case .none:
            print("ssssss")
        }
    }
    func dismiss(dismissingStyle :DismissingStyle) {
        switch dismissingStyle {
        case .Dismiss:
            self.naviagtion?.dismiss(animated: true)
        case .Pop:
            self.naviagtion?.popViewController(animated: true)
        }
    }
    func didFinish(dismissingStyle :DismissingStyle,coordindtor: Coordinator) {
        var childCoordinator = parent_Coordinator?.childCoordinators ?? []
        if let index = childCoordinator.firstIndex(where: { childCoordinator in
            childCoordinator === coordindtor
        }){
            childCoordinator.remove(at: index)
            dismiss(dismissingStyle: dismissingStyle)
        }
    }
    func popToViewController(viewController: AnyClass) {
        if let viewControllers = self.naviagtion?.viewControllers {
            for vc in viewControllers {
                if vc.isKind(of: viewController) {
                    naviagtion?.popToViewController(vc, animated: true)
                }
            }
        }
    }
}

enum PresentingStyle {
    case push
    case Present
}
enum DismissingStyle {
    case Dismiss
    case Pop
}
