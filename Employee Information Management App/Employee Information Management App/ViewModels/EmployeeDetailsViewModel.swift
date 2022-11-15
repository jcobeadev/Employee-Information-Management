//
//  EmployeeDetailsViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import Foundation

final class EmployeeDetailsViewModel {

    let employee: Employee
    let dataManager: EmployeeLocalDataManager
    weak var coordinator: EmployeeDetailsCoordinator?

    init(employee: Employee, dataManager: EmployeeLocalDataManager) {
        self.employee = employee
        self.dataManager = dataManager
    }

    func viewDidDisAppear() {
        coordinator?.didFinish()
    }

    deinit {
        print("deinit EmployeeDetailsViewModel")
    }

}
