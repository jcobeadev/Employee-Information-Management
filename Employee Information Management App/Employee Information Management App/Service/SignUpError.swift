//
//  SignUpError.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import Foundation

enum SignUpError: Error, Equatable {
    case userNameIsEmpty
    case emailIsEmpty
    case emailIsInvalid
    case passwordIsEmpty
    case passwordDoesNotMatch

    static func == (lhs: SignUpError, rhs: SignUpError) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}

extension SignUpError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userNameIsEmpty:
            return "Password is empty."
        case .emailIsEmpty:
            return "Email is empty."
        case .emailIsInvalid:
            return "Invalid email."
        case .passwordIsEmpty:
            return "Password is empty."
        case .passwordDoesNotMatch:
            return "Passwords doesn't match."
        }
    }
}
