//
//  EmployeeDetailsViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import UIKit
import RxSwift
import RxCocoa

final class EmployeeDetailsViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var isResigned: UISwitch!

    var viewModel: EmployeeDetailsViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
        setupInitialTexts()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisAppear()
    }

    deinit {
        print("deinit EmployeeDetailsViewController")
    }

}

extension EmployeeDetailsViewController {
    private func setupViews() {

    }

    private func setupInitialTexts() {
        firstNameTextField.text = viewModel.employee.firstName
        lastNameTextField.text = viewModel.employee.lastName
        roleTextField.text = viewModel.employee.role
        isResigned.isOn = viewModel.employee.isResigned
    }
}

extension EmployeeDetailsViewController {
    private func bind() {

        firstNameTextField
            .rx
            .text.map { $0 ?? "" }
            .bind(to: viewModel.fistNameTextPublishSubject)
            .disposed(by: disposeBag)

        lastNameTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.lastNameTextPublishSubject)
            .disposed(by: disposeBag)

        roleTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.roleTextPublishSubject)
            .disposed(by: disposeBag)

        isResigned
            .rx.isOn
            .bind(to: viewModel.isResignedPublishSubject)
            .disposed(by: disposeBag)

    }
}
