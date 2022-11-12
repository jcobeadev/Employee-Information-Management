//
//  SignUpManager.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

protocol SignUpLocalDataManager {
    typealias SignUpResult = Swift.Result<Company, Error>
    typealias SignUpResultCompletion = (SignUpResult) -> Void

    func signUp(userName: String, email: String, password: String, completion: @escaping SignUpResultCompletion)
}

final class SignupManager: SignUpLocalDataManager {

    func signUp(userName: String, email: String, password: String, completion: @escaping SignUpResultCompletion) {

        let company = Company(id: UUID().uuidString, userName: userName, email: email, password: password, isSelected: true)

        do {
            let companies = try fetchCompanies()

            // already exists
            if companies.contains(where: {$0.email == company.email }) {
                let error = NSError(domain: "Company already exists", code: 9999)
                completion(.failure(error))
            } else {

                var persistableCompanies = companies.map { PersitableCompany(user_name: $0.userName, email: $0.email, password: $0.password, is_selected: false)}

                // select new signed up company
                let persistableCompany = PersitableCompany(user_name: company.userName, email: company.email, password: company.password, is_selected: true)

                persistableCompanies.append(persistableCompany)

                try writeData(companies: persistableCompanies)

                completion(.success(company))
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
            return companies.map { Company(id: $0.id, userName: $0.user_name, email: $0.email, password: $0.password, isSelected: $0.is_selected)}
        } catch {
            throw error
        }
    }

    private func writeData(companies: [PersitableCompany]) throws {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("Companies.json")

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(companies)
            try data.write(to: url)

        } catch {
            throw error
        }
    }
}
