//
//  SignUpLocalDataManager.swift
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
