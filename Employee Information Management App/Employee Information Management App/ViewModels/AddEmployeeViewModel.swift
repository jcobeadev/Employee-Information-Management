//
//  AddEmployeeViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import RxSwift

final class AddEmployeeViewModel {

    private var firstName = ""
    private var lastName = ""
    private var role = ""

    let fistNameTextPublishSubject = PublishSubject<String>()
    let lastNameTextPublishSubject = PublishSubject<String>()
    let roleTextPublishSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()

    let title = "Add"

    var coordinator: AddEmployeeCoordinator?

    func viewDidLoad() {
        Observable.combineLatest(
            fistNameTextPublishSubject
                .asObservable()
                .startWith(""),
            lastNameTextPublishSubject
                .asObservable()
                .startWith(""),
            roleTextPublishSubject
                .asObservable()
                .startWith("")
        ).subscribe(onNext: { firstName, lastName, role in
            self.firstName = firstName
            self.lastName = lastName
            self.role = role
        })
        .disposed(by: disposeBag)
    }

    func viewDidDisappear() {
        coordinator?.didFinishAddEmployee()
    }

    deinit {
        print("deinit from add employee view model")
    }
}
