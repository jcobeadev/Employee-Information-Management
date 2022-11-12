//
//  PersitableCompany.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

struct PersitableCompany: Codable {
    let user_name: String
    let email: String
    let password: String
    var is_selected: Bool
}


struct Company {
    let userName: String
    let email: String
    let password: String
    var isSelected: Bool
}
