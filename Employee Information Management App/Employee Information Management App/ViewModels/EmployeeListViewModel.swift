//
//  EmployeeListViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

final class EmployeeListViewModel {

    let title = "Employees"
    var coordinator: EmployeeListCoordinator?

    private(set) var employees: [Employee] = []

    let dataManager: LocalDataManager

    init(dataManager: LocalDataManager) {
        self.dataManager = dataManager
    }

    // MARK: Life Cycle

    func viewDidLoad() {
        if let employees = try? dataManager.fetchEmployees() {
            self.employees = employees.filter { $0.companyID == CompanyProvider().currentCompany()?.id }
        }
    }

    // MARK: Functionalities

    func tappedAddEmployee() {
         coordinator?.startAddEmployee()
    }

    func tappedLogout() {
        coordinator?.didLogOut()
        print("did logout view model")
    }

    func numOfRows() -> Int {
        return employees.count
    }

    func cellViewModel(at index: IndexPath) -> EmployeeCellViewModel {
        print(employees)
        return EmployeeCellViewModel(employee: employees[index.row])
    }

    deinit {
        print("deinit from employee list view model")
    }

}
