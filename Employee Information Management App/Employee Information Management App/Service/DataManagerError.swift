//
//  DataManagerError.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import Foundation

enum DataManagerError: Error, Equatable {
    case companyDoesNotExist
    case allFiedsShouldNotBeEmpty
}

extension DataManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .companyDoesNotExist:
            return "Company does not exists. \nPlease sign up"
        case .allFiedsShouldNotBeEmpty:
            return "All fields should not be empty."
        }
    }
}
