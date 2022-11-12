//
//  LoginLocalDataManager.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

protocol LoginLocalDataManager {
    typealias LoginResult = Swift.Result<Company, Error>
    typealias LoginResultCompletion = (LoginResult) -> Void

    func login(userName: String, password: String, completion: @escaping LoginResultCompletion)
    func hasSession() -> Bool
}
