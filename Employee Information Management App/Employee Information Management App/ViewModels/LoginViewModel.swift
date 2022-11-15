//
//  LoginViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import RxSwift

final class LoginViewModel {

    private var userName = ""
    private var password = ""

    let userNameTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
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

    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(
            userNameTextPublishSubject
                .asObservable()
                .startWith(""),
            passwordTextPublishSubject
                .asObservable()
                .startWith(""))
            .map { username, password in
                self.userName = username
                self.password = password
                return username.count > 3 && password.count > 3
            }.startWith(false)
    }

    func tappedLogin(completion: @escaping (Error?) -> Void) {
        dataManager.login(userName: userName, password: password) { [weak self] result in
            switch result {
            case .success:
                completion(nil)
                self?.coordinator?.startEmployeeLists(animated: true)
            case let .failure(error):
                completion(error)
            }
        }
    }

    func tappedSignUp() {
        coordinator?.startSignUp()
    }

}
