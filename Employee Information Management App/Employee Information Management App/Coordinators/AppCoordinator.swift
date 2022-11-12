//
//  AppCoordinator.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

protocol Coordinator {
    /// `childCoordinators` is a collection to make sure that
    /// our coordinators are retained and we don't deallocate them immediately
    var childCoordinators: [Coordinator] { get }

    /// Entry point of every coordinator
    func start()
}

final class AppCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)

        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
