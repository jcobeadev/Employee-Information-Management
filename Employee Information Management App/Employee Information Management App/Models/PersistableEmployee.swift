//
//  PersistableEmployee.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

struct PersistableEmployee: Codable {
    let id: String
    let company_id: String
    let first_name: String
    let last_name: String
    let role: String
    let is_resigned: Bool
}
