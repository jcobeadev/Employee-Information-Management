//
//  SignUpViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import RxSwift
import Foundation

enum SignUpError: Error, Equatable {
    case userNameIsEmpty
    case emailIsEmpty
    case emailIsInvalid
    case passwordIsEmpty
    case passwordDoesNotMatch

    static func == (lhs: SignUpError, rhs: SignUpError) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}

extension SignUpError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userNameIsEmpty:
            return "Password is empty."
        case .emailIsEmpty:
            return "Email is empty."
        case .emailIsInvalid:
            return "Invalid email."
        case .passwordIsEmpty:
            return "Password is empty."
        case .passwordDoesNotMatch:
            return "Passwords doesn't match."
        }
    }
}

final class SignUpViewModel {

    private var userName = ""
    private var email = ""
    private var password = ""

    let userNameTextPublishSubject = PublishSubject<String>()
    let emailTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    let confirmPasswordTextPublishSubject = PublishSubject<String>()

    let dataManager: SignUpLocalDataManager

    let disposeBag = DisposeBag()

    var error: SignUpError?
    var coordinator: SignUpCoordinator?

    init(dataManager: SignUpLocalDataManager) {
        self.dataManager = dataManager
    }


    func isFormvalid() -> Observable<Bool> {

        return Observable.combineLatest(
            userNameTextPublishSubject
                .asObservable()
                .startWith(""),
            emailTextPublishSubject
                .asObservable()
                .startWith(""),
            passwordTextPublishSubject
                .asObservable()
                .startWith(""),
            confirmPasswordTextPublishSubject
                .asObservable()
                .startWith(""))
            .map { username, email, password, confirmPassword in

                self.userName = username
                self.email = email
                self.password = password

                print(username, email, password, confirmPassword)

                return self.error == nil
        }
    }

    func viewDidDisappear() {
        coordinator?.didFinishSignUp()
    }

    func signUp() {
        self.dataManager.signUp(userName: userName, email: email, password: password){ result in
            switch result {
            case let .success(company):
                print("signUp", company)
            case let .failure(error):
                print("signUp", error)
            }
        }
    }

    deinit {
        print("deinit from sign up view model")
    }


}
