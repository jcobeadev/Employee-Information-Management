//
//  EmployeeLocalDataManager.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/14/22.
//

import Foundation

protocol EmployeeLocalDataManager {
    typealias AddEmployeeResult = Swift.Result<Employee, Error>
    typealias AddEmployeeResultCompletion = (AddEmployeeResult) -> Void
    func addEmployee(firstName: String, lastName: String, role: String, completion: @escaping AddEmployeeResultCompletion)

    typealias EditEmployeeResult = Swift.Result<(), Error>
    typealias EditEmployeeResultCompletion = (EditEmployeeResult) -> Void
    func editEmployee(employee: Employee, completion: @escaping EditEmployeeResultCompletion)
}
