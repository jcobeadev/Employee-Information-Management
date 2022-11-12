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
            print("here")
            coordinator?.startEmployeeLists()
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

    func tappedLogin() {
        dataManager.login(userName: userName, password: password) { result in
            switch result {
            case let .success(company):
                print("company", company)
            case let .failure(error):
                print("error", error)
            }
        }
    }

    func tappedSignUp() {
        coordinator?.startSignUp()
    }

}
