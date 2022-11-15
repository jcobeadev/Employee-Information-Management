//
//  LocalDataManager.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

enum Filename: String {
    case Companies
    case Employees
}

final class LocalDataManager {
    private func fetchCompanies() throws -> [Company] {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("\(Filename.Companies.rawValue).json")
            let jsonData = try Data(contentsOf: url)
            if jsonData.isEmpty { return [] }
            let companies = try JSONDecoder().decode([PersitableCompany].self, from: jsonData)
            return companies.map { Company(id: $0.id, userName: $0.user_name, email: $0.email, password: $0.password, isSelected: $0.is_selected)}
        } catch {
            throw error
        }
    }

    private func writeData(companies: [PersitableCompany]) throws {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("\(Filename.Companies.rawValue).json")

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(companies)
            try data.write(to: url)

        } catch {
            throw error
        }
    }

    func fetchEmployees() throws -> [Employee] {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("\(Filename.Employees.rawValue).json")
            let jsonData = try Data(contentsOf: url)
            if jsonData.isEmpty { return [] }
            let employees = try JSONDecoder().decode([PersistableEmployee].self, from: jsonData)
            return employees.map { Employee(id: $0.id, companyID: $0.company_id, firstName: $0.first_name, lastName: $0.last_name, role: $0.role, isResigned: $0.is_resigned)}
        } catch {
            throw error
        }
    }

    private func writeData(employees: [PersistableEmployee]) throws {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("\(Filename.Employees.rawValue).json")

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(employees)
            try data.write(to: url)
        } catch {
            throw error
        }
    }

}

// MARK: - Employee
extension LocalDataManager: EmployeeLocalDataManager {
    func addEmployee(firstName: String, lastName: String, role: String, completion: @escaping AddEmployeeResultCompletion) {
        let companyProvider = CompanyProvider()

        let employee = Employee(
            id: UUID().uuidString,
            companyID: companyProvider.currentCompany()?.id ?? "",
            firstName: firstName,
            lastName: lastName,
            role: role,
            isResigned: false
        )

        do {
            var employees = try fetchEmployees()
            employees.append(employee)
            try writeData(employees: employees.toLocal())
            completion(.success(employee))
        } catch {
            completion(.failure(error))
        }
    }

    func editEmployee(employee: Employee, completion: @escaping EditEmployeeResultCompletion) {
        do {
            var employees = try fetchEmployees()
            if let index = employees.firstIndex(where: { $0.id == employee.id }) {
                employees[index] = employee
            }
            try writeData(employees: employees.toLocal())
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

private extension Array where Element == Employee {
    func toLocal() -> [PersistableEmployee] {
        return map { PersistableEmployee(id: $0.id, company_id: $0.companyID, first_name: $0.firstName, last_name: $0.lastName, role: $0.role, is_resigned: $0.isResigned)}
    }
}


// MARK: - Login
extension LocalDataManager: LoginLocalDataManager {
    func login(userName: String, password: String, completion: @escaping LoginResultCompletion) {

        do {
            let companies = try fetchCompanies()

            if let company = companies.first(where: { $0.userName == userName && $0.password == password }) {

                var arr = [Company]()
                for var object in companies {
                    object.isSelected = false
                    if object.id == company.id { object.isSelected = true }
                    arr.append(object)
                }

                try writeData(companies: arr.map { PersitableCompany(id: $0.id, user_name: $0.userName, email: $0.email, password: $0.password, is_selected: $0.isSelected)})

                completion(.success(company))
            } else {
                let error = NSError(domain: "Company does not exists. Please sign up.", code: 9999, userInfo: nil)
                completion(.failure(error))
            }

        } catch {
            completion(.failure(error))
        }

    }

    func hasSession() -> Bool {
        if let companies = try? fetchCompanies() {
            for company in companies {
                if company.isSelected == true { return true }
            }
            return false
        }
        return false
    }
}

// MARK: - Sign Up

extension LocalDataManager: SignUpLocalDataManager {
    func signUp(userName: String, email: String, password: String, completion: @escaping SignUpResultCompletion) {

        let company = Company(id: UUID().uuidString, userName: userName, email: email, password: password, isSelected: true)

        do {
            let companies = try fetchCompanies()

            // already exists
            if companies.contains(where: {$0.email == company.email }) {
                let error = NSError(domain: "Company already exists", code: 9999)
                completion(.failure(error))
            } else {

                var persistableCompanies = companies.map { PersitableCompany(id: $0.id, user_name: $0.userName, email: $0.email, password: $0.password, is_selected: false)}

                // select new signed up company
                let persistableCompany = PersitableCompany(id: UUID().uuidString, user_name: company.userName, email: company.email, password: company.password, is_selected: true)

                persistableCompanies.append(persistableCompany)

                try writeData(companies: persistableCompanies)

                completion(.success(company))
            }

        } catch {
            completion(.failure(error))
        }

    }
}
