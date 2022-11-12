//
//  EmployeeCellViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/13/22.
//

import Foundation

final class EmployeeCellViewModel {

    let employee: Employee

    init(employee: Employee) {
        self.employee = employee
    }

    var fullName: String {
        return "\(employee.lastName), \(employee.firstName)".capitalized
    }

    var role: String {
        return employee.role
    }

    var isResigned: Bool {
        return employee.isResigned
    }

}
