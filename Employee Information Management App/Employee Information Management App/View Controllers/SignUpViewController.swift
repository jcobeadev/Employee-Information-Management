//
//  SignUpViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: UIViewController {

    var viewModel: SignUpViewModel!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }

    private func setupViews() {
        userNameTextField.becomeFirstResponder()
    }

    private func bind() {
        userNameTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.userName)
            .disposed(by: disposeBag)

        emailTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.firstPassword)
            .disposed(by: disposeBag)

        confirmPasswordTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.secondPassword)
            .disposed(by: disposeBag)

        viewModel.isValidInput.bind(to: signUpButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.isValidInput.map { $0 ? 1 : 0.6 }.bind(to: signUpButton.rx.alpha).disposed(by: disposeBag)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    @IBAction func tappedSignUpButton(_ sender: UIButton) {
        viewModel.signUp { [weak self] error in
            guard let error else { return }
            self?.presentErrorAlert(error)
        }
    }

}
