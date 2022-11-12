//
//  LoginManager.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

/*
struct PersistableEmployee: Codable {
    let id: String
    let first_name: String
    let last_name: String
    let role: String
    let resigned: Bool
}

struct Employee {
    let id: UUID
    let first_name: String
    let last_name: String
    let role: String
    let resigned: Bool
}
*/

protocol LoginLocalDataManager {
    typealias LoginResult = Swift.Result<Company, Error>
    typealias LoginResultCompletion = (LoginResult) -> Void

    func login(userName: String, password: String, completion: @escaping LoginResultCompletion)
}

final class LoginDataManager: LoginLocalDataManager {

    func login(userName: String, password: String, completion: @escaping LoginResultCompletion) {

        do {
            let companies = try fetchCompanies()
            dump(companies, name: "companies")
            print(userName, password)

            if let company = companies.first(where: { $0.userName == userName && $0.password == password }) {
                completion(.success(company))
            } else {
                let error = NSError(domain: "Company does not exists. Please sign up.", code: 9999, userInfo: nil)
                completion(.failure(error))
            }

        } catch {
            completion(.failure(error))
        }

    }

    private func fetchCompanies() throws -> [Company] {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("Companies.json")
            let jsonData = try Data(contentsOf: url)
            if jsonData.isEmpty { return [] }
            let companies = try JSONDecoder().decode([PersitableCompany].self, from: jsonData)
            return companies.map { Company(userName: $0.user_name, email: $0.email, password: $0.password, isSelected: $0.is_selected)}
        } catch {
            throw error
        }
    }
}
