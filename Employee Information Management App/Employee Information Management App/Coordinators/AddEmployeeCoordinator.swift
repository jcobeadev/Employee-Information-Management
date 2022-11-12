//
//  AddEmployeeCoordinator.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class AddEmployeeCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    var parentCoordinator: EmployeeListCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // create add event view controller
        let modalNavigationController = UINavigationController()
        let addEmployeeViewController: AddEmployeeViewController = .instantiate()
        modalNavigationController.setViewControllers([addEmployeeViewController], animated: false)

        // create add event view model
        let addEmployeeViewModel = AddEmployeeViewModel()
        addEmployeeViewModel.coordinator = self
        addEmployeeViewController.viewModel = addEmployeeViewModel

        // present modally controller using navigation controller
        navigationController.present(modalNavigationController, animated: true, completion: nil)
    }

    func didFinishAddEmployee() {
        parentCoordinator?.childDidFinish(self)
    }

    deinit {
        print("deinit from add employee coordinator")
    }
}
