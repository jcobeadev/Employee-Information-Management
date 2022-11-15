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

    func viewDidLoad() {
        reload()
    }

    func reload() {
        if let employees = try? dataManager.fetchEmployees() {
            let filteredEmployees = employees.filter { $0.companyID == CompanyProvider().currentCompany()?.id }
            self.employees.on(.next(filteredEmployees.reversed()))
        }
    }

    func tappedAddEmployee() {
         coordinator?.startAddEmployee()
    }

    func tappedItem(at indexPath: IndexPath) {
        guard let employees = try? employees.value() else { return }
        print(employees[indexPath.row])

        // tell coordinator that we're going to employee detail screen
    }

    func tappedLogout() {
        coordinator?.didLogOut()
    }

    deinit {
        print("deinit from employee list view model")
    }

}
