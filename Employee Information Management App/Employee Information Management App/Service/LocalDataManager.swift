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
            let persistableCompanies = try JSONDecoder().decode([PersistableCompany].self, from: jsonData)

            return persistableCompanies.toHighLevelEntity()
        } catch {
            throw error
        }
    }

    private func writeData(companies: [PersistableCompany]) throws {
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
            let persistableEmployees = try JSONDecoder().decode([PersistableEmployee].self, from: jsonData)

            return persistableEmployees.toHighLevelEntity()
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
            try writeData(employees: employees.toLowLevelEntity())
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
            try writeData(employees: employees.toLowLevelEntity())
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

// MARK: - Login
extension LocalDataManager: LoginLocalDataManager {
    func login(userName: String, password: String, completion: @escaping LoginResultCompletion) {

        do {
            let companies = try fetchCompanies()

            if let company = companies.first(where: { $0.userName == userName }) {

                guard company.password == password else {
                    throw DataManagerError.wrongPassword
                }

                var _companies = [Company]()
                for var object in companies {
                    object.isSelected = false
                    if object.id == company.id { object.isSelected = true }
                    _companies.append(object)
                }

                try writeData(companies: _companies.toLowLevelEntity())

                completion(.success(company))
            } else {
                let error: DataManagerError = .companyDoesNotExist
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

// MARK: - Logout
extension LocalDataManager: LogoutLocalDataManager {
    func logout(completion: @escaping LogoutResultCompletion) {
        do {
            let companies = try fetchCompanies()
            /// set all companies `isSelected` to false
            let persistableCompanies = companies.map { PersistableCompany(id: $0.id, user_name: $0.userName, email: $0.email, password: $0.password, is_selected: false) }

            try writeData(companies: persistableCompanies)

            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
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

                // we didn't use helper, because we need to set isSelected to false.
                var persistableCompanies = companies.map { PersistableCompany(id: $0.id, user_name: $0.userName, email: $0.email, password: $0.password, is_selected: false) }

                // select new signed up company
                let persistableCompany = PersistableCompany(id: UUID().uuidString, user_name: company.userName, email: company.email, password: company.password, is_selected: true)

                persistableCompanies.append(persistableCompany)

                try writeData(companies: persistableCompanies)

                completion(.success(company))
            }

        } catch {
            completion(.failure(error))
        }

    }
}
