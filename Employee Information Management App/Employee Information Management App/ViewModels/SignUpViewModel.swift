//
//  SignUpViewModel.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import RxSwift

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

import Foundation

protocol SignUpLocalDataManager {
    typealias SignUpResult = Swift.Result<Company, Error>
    typealias SignUpResultCompletion = (SignUpResult) -> Void

    func signUp(userName: String, email: String, password: String, completion: @escaping SignUpResultCompletion)
}

final class SignupManager: SignUpLocalDataManager {

    func signUp(userName: String, email: String, password: String, completion: @escaping SignUpResultCompletion) {

        let company = Company(userName: userName, email: email, password: password, isSelected: true)

        do {
            let companies = try fetchCompanies()

            // already exists
            if companies.contains(where: {$0.email == company.email }) {
                let error = NSError(domain: "Company already exists", code: 9999)
                completion(.failure(error))
            } else {

                var persistableCompanies = companies.map { PersitableCompany(user_name: $0.userName, email: $0.email, password: $0.password, is_selected: false)}

                // select new signed up company
                let persistableCompany = PersitableCompany(user_name: company.userName, email: company.email, password: company.password, is_selected: true)

                persistableCompanies.append(persistableCompany)

                try writeData(companies: persistableCompanies)

                completion(.success(company))
            }

        } catch {
            completion(.failure(error))
        }

    }


    private func fetchCompanies() throws -> [Company] {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("Companies.json")
            let jsonData = try Data(contentsOf: url)
            if jsonData.isEmpty { return [] }
            let companies = try JSONDecoder().decode([PersitableCompany].self, from: jsonData)
            return companies.map { Company(userName: $0.user_name, email: $0.email, password: $0.password, isSelected: $0.is_selected)}
        } catch {
            throw error
        }
    }

    private func writeData(companies: [PersitableCompany]) throws {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
            let url = documentDirectory.appendingPathComponent("Companies.json")

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(companies)
            try data.write(to: url)

        } catch {
            throw error
        }
    }
}

final class SignUpViewModel {

    private var userName = ""
    private var email = ""
    private var password = ""

    let userNameTextPublishSubject = PublishSubject<String>()
    let emailTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    let confirmPasswordTextPublishSubject = PublishSubject<String>()

    let dataManager: SignUpLocalDataManager = SignupManager()

    let disposeBag = DisposeBag()

    var error: SignUpError?

    var coordinator: SignUpCoordinator?

    func isFormvalid() -> Observable<Bool> {

        return Observable.combineLatest(
            userNameTextPublishSubject
                .asObservable()
                .startWith(""),
            emailTextPublishSubject
                .asObservable()
                .startWith(""),
            passwordTextPublishSubject
                .asObservable()
                .startWith(""),
            confirmPasswordTextPublishSubject
                .asObservable()
                .startWith(""))
            .map { username, email, password, confirmPassword in

                self.userName = username
                self.email = email
                self.password = password

                print(username, email, password, confirmPassword)

                return self.error == nil
        }
    }

    func viewDidDisappear() {
        coordinator?.didFinishSignUp()
    }

    func signUp() {
        self.dataManager.signUp(userName: userName, email: email, password: password){ result in
            switch result {
            case let .success(company):
                print("signUp", company)
            case let .failure(error):
                print("signUp", error)
            }
        }
    }

    deinit {
        print("deinit from sign up view model")
    }


}
