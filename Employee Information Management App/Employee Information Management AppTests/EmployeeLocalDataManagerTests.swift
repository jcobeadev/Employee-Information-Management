//
//  EmployeeLocalDataManagerTests.swift
//  Employee Information Management AppTests
//
//  Created by Jayco Bea on 11/14/22.
//

import XCTest
@testable import Employee_Information_Management_App

final class EmployeeLocalDataManagerTests: XCTestCase {

    func test_init_doesNotDoAnything() {
        let sut = makeSUT()


    }

    // Helpers
    private func makeSUT() -> EmployeeLocalDataManager {
        let sut = LocalDataManager()

        let messages: [EmployeeLocalDataManager.AddEmployeeResult] = []


        return LocalDataManager()
    }
}
