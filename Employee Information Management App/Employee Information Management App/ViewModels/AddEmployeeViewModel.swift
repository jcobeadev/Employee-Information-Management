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
    weak var coordinator: AddEmployeeCoordinator?
    let dataManager: EmployeeLocalDataManager

    init(dataManager: EmployeeLocalDataManager) {
        self.dataManager = dataManager
    }

    func viewDidLoad() {
        observe()
    }

    func viewDidDisappear() {
        coordinator?.didFinish()
    }

    func tappedDoneButton() {
        dataManager.addEmployee(firstName: firstName, lastName: lastName, role: role) { result in
            switch result {
            case let .success(employee):
                print(employee)
            case let .failure(error):
                print(error)
            }
            self.coordinator?.didFinishSaveEvent()
        }
    }

    deinit {
        print("deinit from add employee view model")
    }
}

extension AddEmployeeViewModel {
    private func observe() {
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
}
