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

    func tappedAddEmployee() {
         coordinator?.startAddEmployee()
    }

}
