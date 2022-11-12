//
//  Company.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

public struct Company: Codable {
    var id: String
    let userName: String
    let email: String
    let password: String
    var isSelected: Bool
}
