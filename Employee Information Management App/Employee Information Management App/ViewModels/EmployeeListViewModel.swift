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

        // tell coordinator that we're going to employee detail screen
        coordinator?.startEditEmployee(employee: employees[indexPath.row])
    }

    func tappedLogout(completion: @escaping (Error?) -> ()) {
        dataManager.logout { [weak self] result in
            switch result {
            case .success:
                self?.coordinator?.didLogOut()
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}
