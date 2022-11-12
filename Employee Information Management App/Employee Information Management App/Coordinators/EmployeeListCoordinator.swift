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

    var parentCoordinator: LoginCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let employeeListViewController: EmployeeListViewController = .instantiate()
        let employeeListViewModel = EmployeeListViewModel(dataManager: LocalDataManager())
        employeeListViewModel.coordinator = self
        employeeListViewController.viewModel = employeeListViewModel

        UIView.performWithoutAnimation {
            self.navigationController.show(employeeListViewController, sender: nil)
        }

    }

    func startAddEmployee() {
        let addEmployeeCoordinator = AddEmployeeCoordinator(navigationController: navigationController)
        addEmployeeCoordinator.parentCoordinator = self
        childCoordinators.append(addEmployeeCoordinator)
        addEmployeeCoordinator.start()
    }

    func childDidFinish(_ childCoordinator: Coordinator) {

        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === childCoordinator {
                childCoordinators.remove(at: index)
                break
            }
        }

    }

    func didLogOut() {
        parentCoordinator?.childDidFinish(self)
        print("did logout coordinator")
    }

    deinit {
        print("deinit from employee list coordinator")
    }
}
