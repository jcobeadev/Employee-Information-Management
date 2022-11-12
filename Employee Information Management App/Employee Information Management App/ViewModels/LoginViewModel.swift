//
//  LoginViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import RxSwift

final class LoginViewModel {

    let userNameTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()

    var coordinator: LoginCoordinator?

    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(
            userNameTextPublishSubject
                .asObservable()
                .startWith(""),
            passwordTextPublishSubject
                .asObservable()
                .startWith(""))
            .map { username, password in
                return username.count > 3 && password.count > 3
            }.startWith(false)
    }

    func tappedSignUp() {
        coordinator?.startSignUp()
    }

}
