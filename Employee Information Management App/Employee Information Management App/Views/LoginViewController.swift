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

        userNameTextField.becomeFirstResponder()

        userNameTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.userNameTextPublishSubject)
            .disposed(by: disposeBag)

        passwordTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.passwordTextPublishSubject)
            .disposed(by: disposeBag)

        viewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.isValid().map { $0 ? 1 : 0.6 }.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }

    @IBAction func tappedLoginButton(_ sender: UIButton) {
        print("tapped login button")
    }

    @IBAction func tappedSignUpButton(_ sender: UIButton) {        
        viewModel.tappedSignUp()
    }
}
