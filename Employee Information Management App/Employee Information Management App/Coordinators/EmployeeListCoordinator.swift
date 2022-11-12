//
//  EmployeeListCoordinator.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class EmployeeListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let employeeListViewController = EmployeeListViewController.instantiate()
        let employeeListViewModel = EmployeeListViewModel()
        employeeListViewController.viewModel = employeeListViewModel
        navigationController.setViewControllers([employeeListViewController], animated: false)
    }
}
