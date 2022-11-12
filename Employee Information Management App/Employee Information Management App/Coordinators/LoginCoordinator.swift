//
//  LoginCoordinator.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class LoginCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginViewController: LoginViewController = .instantiate()
        navigationController.setViewControllers([loginViewController], animated: false)
    }

}
