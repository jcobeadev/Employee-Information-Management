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


    private let disposeBag = DisposeBag()
    var userName: BehaviorSubject<String> = BehaviorSubject(value: "")
    var email: BehaviorSubject<String> = BehaviorSubject(value: "")
    var firstPassword: BehaviorSubject<String> = BehaviorSubject(value: "")
    var secondPassword: BehaviorSubject<String> = BehaviorSubject(value: "")

    private var isValidUsername: Observable<Bool> {
        userName.map { $0.count > 3 }
    }

    private var isValidEmail: Observable<Bool> {
        email.map { $0.isValidEmail() }
    }

    private var isValidFirstPassword: Observable<Bool> {
        firstPassword.map { $0.count > 3 }
    }

    private var isValidSecondPassword: Observable<Bool> {
        secondPassword.map { $0.count > 3 }
    }

    var isValidInput: Observable<Bool> {
        return Observable.combineLatest(isValidUsername, isValidEmail, isValidFirstPassword, isValidSecondPassword).map { $0 && $1 && $2 && $3 }
    }

    let dataManager: SignUpLocalDataManager
    var coordinator: SignUpCoordinator?

    init(dataManager: SignUpLocalDataManager) {
        self.dataManager = dataManager
    }

    func viewDidDisappear() {
        coordinator?.didFinish()
    }

    func signUp(completion: @escaping (Error?) -> Void) {
        do {
            let userName = try userName.value()
            let email = try email.value()
            let firstPassword = try firstPassword.value()
            let secondPassword = try secondPassword.value()

            guard firstPassword == secondPassword else { throw SignUpError.passwordDoesNotMatch }

            dataManager.signUp(
                userName: userName,
                email: email,
                password: firstPassword) { [weak self] result in
                    switch result {
                    case .success:
                        completion(nil)
                        self?.coordinator?.didFinishSignUp()
                    case let .failure(error):
                        completion(error)
                    }
                }
        } catch {
            completion(error)
        }
    }

}
