//
//  SignUpViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

final class SignUpViewModel {

    var coordinator: SignUpCoordinator?

    func viewDidDisappear() {
        coordinator?.didFinishSignUp()
    }

    deinit {
        print("deinit from sign up view model")
    }


}
