//
//  AddEmployeeViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import Foundation

final class AddEmployeeViewModel {

    var coordinator: AddEmployeeCoordinator?

    func viewDidDisappear() {
        coordinator?.didFinishAddEmployee()
    }

    deinit {
        print("deinit from add employee view model")
    }
}
