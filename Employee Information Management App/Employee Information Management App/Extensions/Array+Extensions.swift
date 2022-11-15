//
//  Array+Extensions.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import Foundation


extension Array where Element == Employee {
    func toLowLevelEntity() -> [PersistableEmployee] {
        return map { PersistableEmployee(id: $0.id, company_id: $0.companyID, first_name: $0.firstName, last_name: $0.lastName, role: $0.role, is_resigned: $0.isResigned)}
    }
}

extension Array where Element == PersistableEmployee {
    func toHighLevelEntity() -> [Employee] {
        return map { Employee(id: $0.id, companyID: $0.company_id, firstName: $0.first_name, lastName: $0.last_name, role: $0.role, isResigned: $0.is_resigned)}
    }
}

extension Array where Element == Company {
    func toLowLevelEntity() -> [PersistableCompany] {
        return map { PersistableCompany(id: $0.id, user_name: $0.userName, email: $0.email, password: $0.password, is_selected: $0.isSelected)}
    }
}

extension Array where Element == PersistableCompany {
    func toHighLevelEntity() -> [Company] {
        return map { Company(id: $0.id, userName: $0.user_name, email: $0.email, password: $0.password, isSelected: $0.is_selected)}
    }
}
