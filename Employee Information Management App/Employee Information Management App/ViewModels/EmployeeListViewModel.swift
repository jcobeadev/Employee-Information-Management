//
//  EmployeeListViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation
import RxSwift
import RxCocoa

final class EmployeeListViewModel {

    let title = "Employees"
    var coordinator: EmployeeListCoordinator?
    let dataManager: LocalDataManager

    var employees = BehaviorSubject(value: [Employee]())

    init(dataManager: LocalDataManager) {
        self.dataManager = dataManager
    }

    // MARK: Life Cycle
    func viewDidLoad() {
        reload()
    }

    // MARK: Functionalities

    func reload() {
        if let employees = try? dataManager.fetchEmployees() {
            let filteredEmployees = employees.filter { $0.companyID == CompanyProvider().currentCompany()?.id }
            self.employees.on(.next(filteredEmployees.reversed()))
        }
    }

    func tappedAddEmployee() {
         coordinator?.startAddEmployee()
    }

    func tappedLogout() {
        coordinator?.didLogOut()
        print("did logout view model")
    }


    deinit {
        print("deinit from employee list view model")
    }

}
