//
//  LoginViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {

    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
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

        passwordTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        viewModel.isValidInput.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        viewModel.isValidInput.map { $0 ? 1 : 0.6 }.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }

    @IBAction func tappedLoginButton(_ sender: UIButton) {
        viewModel.tappedLogin { [weak self] error in
            guard let error else { return }
            self?.presentErrorAlert(error)
        }
    }

    @IBAction func tappedSignUpButton(_ sender: UIButton) {        
        viewModel.tappedSignUp()
    }

}
