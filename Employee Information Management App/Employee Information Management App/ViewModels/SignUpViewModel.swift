//
//  SignUpViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import RxSwift

final class SignUpViewModel {

    let userNameTextPublishSubject = PublishSubject<String>()
    let emailTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    let confirmPasswordTextPublishSubject = PublishSubject<String>()

    var coordinator: SignUpCoordinator?

    func viewDidDisappear() {
        coordinator?.didFinishSignUp()
    }

    deinit {
        print("deinit from sign up view model")
    }


}
