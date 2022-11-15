//
//  LogoutLocalDataManager.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import Foundation

protocol LogoutLocalDataManager {
    typealias LogoutResult = Swift.Result<(), Error>
    typealias LogoutResultCompletion = (LogoutResult) -> Void

    func logout(completion: @escaping LogoutResultCompletion)
}
