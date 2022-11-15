//
//  LoginViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import RxSwift

final class LoginViewModel {

    private let disposeBag = DisposeBag()
    var userName: BehaviorSubject<String> = BehaviorSubject(value: "")
    var password: BehaviorSubject<String> = BehaviorSubject(value: "")

    private var isValidUsername: Observable<Bool> {
        userName.map { $0.count > 3 }
    }

    private var isValidPassword: Observable<Bool> {
        password.map { $0.count > 3 }
    }

    var isValidInput: Observable<Bool> {
        return Observable.combineLatest(isValidUsername, isValidPassword).map { $0 && $1 }
    }

    let dataManager: LoginLocalDataManager
    init(dataManager: LoginLocalDataManager) {
        self.dataManager = dataManager
    }

    var coordinator: LoginCoordinator?

    func viewDidLoad() {
        if dataManager.hasSession() {
            coordinator?.startEmployeeLists(animated: false)
        }
    }

    func tappedLogin(completion: @escaping (Error?) -> Void) {

        do {
            let userName = try userName.value()
            let password = try password.value()

            dataManager.login(userName: userName, password: password) { [weak self] result in
                switch result {
                case .success:
                    completion(nil)
                    self?.coordinator?.startEmployeeLists(animated: true)
                case let .failure(error):
                    completion(error)
                }
            }
        } catch {
            completion(error)
        }

    }

    func resetInput() {
    }

    func tappedSignUp() {
        coordinator?.startSignUp()
    }

}
