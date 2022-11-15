//
//  EmployeeListCoordinator.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class EmployeeListCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    var onSaveEvent = {}

    private let navigationController: UINavigationController

    var parentCoordinator: LoginCoordinator?
    let animated: Bool

    init(navigationController: UINavigationController, animated: Bool) {
        self.navigationController = navigationController
        self.animated = animated
    }

    func start() {
        let employeeListViewController: EmployeeListViewController = .instantiate()
        let employeeListViewModel = EmployeeListViewModel(dataManager: LocalDataManager())
        employeeListViewModel.coordinator = self
        onSaveEvent = employeeListViewModel.reload
        employeeListViewController.viewModel = employeeListViewModel

        if animated {
            self.navigationController.show(employeeListViewController, sender: nil)
        } else {
            UIView.performWithoutAnimation {
                self.navigationController.show(employeeListViewController, sender: nil)
            }
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
    }

    deinit {
        print("deinit from employee coordinator")
    }
}
