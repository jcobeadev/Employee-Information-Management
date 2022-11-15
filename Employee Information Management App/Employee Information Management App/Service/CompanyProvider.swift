//
//  CompanyProvider.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

public protocol PersistedCompanyProvider {
    func currentCompany() -> Company?
}

final class CompanyProvider: PersistedCompanyProvider {
    func currentCompany() -> Company? {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("\(Filename.Companies.rawValue).json")
            let jsonData = try Data(contentsOf: url)
            if jsonData.isEmpty { return nil  }
            let companies = try JSONDecoder().decode([PersitableCompany].self, from: jsonData)
            let company = companies.map { Company(id: $0.id, userName: $0.user_name, email: $0.email, password: $0.password, isSelected: $0.is_selected)}.first(where: { $0.isSelected == true }  )
            return company
        } catch {
            print(error)
            return nil
        }
    }
}
