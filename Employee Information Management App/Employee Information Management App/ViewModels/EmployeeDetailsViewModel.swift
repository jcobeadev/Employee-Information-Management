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

    var employee: Employee
    let dataManager: EmployeeLocalDataManager
    weak var coordinator: EmployeeDetailsCoordinator?

    // Rx
    var firstName = BehaviorSubject<String>(value: "")

    private let disposeBag = DisposeBag()

    init(employee: Employee, dataManager: EmployeeLocalDataManager) {
        self.employee = employee
        self.dataManager = dataManager
    }

    func viewDidLoad() {
        observe()

        firstName.on(.next(employee.firstName))
    }

    func viewDidDisAppear() {
        coordinator?.didFinish()
    }

    func tappedSaveButton() {
        dataManager.editEmployee(employee: employee) { result in
            switch result {
            case .success:
                print("done saving..")
            case let .failure(error):
                print(error)
            }
            // self.coordinator?.didFinishSaveEvent()
        }
    }

    deinit {
        print("deinit EmployeeDetailsViewModel")
    }

}

// MARK: Oberserver
extension EmployeeDetailsViewModel {
    private func observe() {

    }
}
