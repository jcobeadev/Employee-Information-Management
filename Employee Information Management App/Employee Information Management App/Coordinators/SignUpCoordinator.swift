//
//  SignUpCoordinator.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class SignUpCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    var parentCoordinator: LoginCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let signUpViewController: SignUpViewController = .instantiate()
        let signUpViewModel = SignUpViewModel(dataManager: LocalDataManager())
        signUpViewModel.coordinator = self
        signUpViewController.viewModel = signUpViewModel

        navigationController.present(signUpViewController, animated: true, completion: nil)
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

    func didFinishSignUp() {
        didFinish()
        navigationController.dismiss(animated: true) {
            self.parentCoordinator?.startEmployeeLists(animated: true)
        }
    }

}
