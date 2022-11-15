//
//  AddEmployeeViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import RxSwift

final class AddEmployeeViewModel {

    private let disposeBag = DisposeBag()
    var firstName: BehaviorSubject<String> = BehaviorSubject(value: "")
    var lastName: BehaviorSubject<String> = BehaviorSubject(value: "")
    var role: BehaviorSubject<String> = BehaviorSubject(value: "")

    private var isFirstNameValid: Observable<Bool> {
        firstName.map { !$0.isEmpty }
    }

    private var isLastNameValid: Observable<Bool> {
        lastName.map { !$0.isEmpty }
    }

    private var isRoleValid: Observable<Bool> {
        role.map { !$0.isEmpty }
    }

    var isValidInput: Observable<Bool> {
        return Observable.combineLatest(isFirstNameValid, isLastNameValid, isRoleValid).map { $0 && $1 && $2 }
    }

    let title = "Add"
    weak var coordinator: AddEmployeeCoordinator?
    let dataManager: EmployeeLocalDataManager

    init(dataManager: EmployeeLocalDataManager) {
        self.dataManager = dataManager
    }

    func viewDidDisappear() {
        coordinator?.didFinish()
    }

    func tappedDoneButton(completion: @escaping (Error?) -> Void) {

        do {
            let firstName = try firstName.value()
            let lastName = try lastName.value()
            let role = try role.value()

            guard !firstName.isEmpty && !lastName.isEmpty && !role.isEmpty else {
                throw DataManagerError.allFiedsShouldNotBeEmpty
            }

            dataManager.addEmployee(firstName: firstName, lastName: lastName, role: role) { [weak self] result in
                switch result {
                case .success:
                    self?.coordinator?.didFinishSaveEvent()
                    completion(nil)
                case let .failure(error):
                    completion(error)
                }
            }

        } catch {
            completion(error)
        }
    }

}
