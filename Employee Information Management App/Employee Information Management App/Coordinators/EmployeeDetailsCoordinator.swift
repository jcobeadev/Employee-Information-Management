//
//  EmployeeDetailsCoordinator.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import UIKit

final class EmployeeDetailsCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let employee: Employee

    private let parentCoordinator: EmployeeListCoordinator

    init(navigationController: UINavigationController, parentCoordinator: EmployeeListCoordinator, employee: Employee) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.employee = employee
    }

    func start() {
        let viewController: EmployeeDetailsViewController = .instantiate()
        let viewModel = EmployeeDetailsViewModel(employee: employee, dataManager: LocalDataManager())

        viewModel.coordinator = self
        viewController.viewModel = viewModel

        navigationController.show(viewController, sender: nil)
    }

    func didFinish() {
        parentCoordinator.childDidFinish(self)
    }

    deinit {
        print("deinit EmployeeDetailsCoordinator")
    }

}
