//
//  EmployeeDetailsViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import Foundation
import RxSwift
import RxCocoa

final class EmployeeDetailsViewModel {

    let title = "Employee Details"
    var employee: Employee
    let dataManager: EmployeeLocalDataManager
    weak var coordinator: EmployeeDetailsCoordinator?

    // Rx
    let fistNameTextPublishSubject = PublishSubject<String>()
    let lastNameTextPublishSubject = PublishSubject<String>()
    let roleTextPublishSubject = PublishSubject<String>()
    let isResignedPublishSubject = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()

    init(employee: Employee, dataManager: EmployeeLocalDataManager) {
        self.employee = employee
        self.dataManager = dataManager
    }

    func viewDidLoad() {
        observe()
    }

    func viewDidDisAppear() {
        coordinator?.didFinish()
    }

    func tappedSaveButton() {
        dataManager.editEmployee(employee: employee) { [weak self] result in
            switch result {
            case .success:
                self?.coordinator?.didFinishSaveEvent()
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: Oberserver
extension EmployeeDetailsViewModel {
    private func observe() {

        fistNameTextPublishSubject
            .asObservable()
            .startWith(employee.firstName)
            .subscribe(onNext: { [weak self] firstName in
                self?.employee.firstName = firstName
            })
            .disposed(by: disposeBag)

        lastNameTextPublishSubject
            .asObservable()
            .startWith(employee.lastName)
            .subscribe(onNext: { [weak self] lastName in
                self?.employee.lastName = lastName
            })
            .disposed(by: disposeBag)

        roleTextPublishSubject
            .asObservable()
            .startWith(employee.role)
            .subscribe(onNext: { [weak self] role in
                self?.employee.role = role
            })
            .disposed(by: disposeBag)

        isResignedPublishSubject
            .asObservable()
            .startWith(employee.isResigned)
            .subscribe(onNext: { [weak self] isResigned in
                self?.employee.isResigned = isResigned
            })
            .disposed(by: disposeBag)
    }
}
