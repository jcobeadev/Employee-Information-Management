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
            .bind(to: viewModel.userNameTextPublishSubject)
            .disposed(by: disposeBag)

        emailTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.emailTextPublishSubject)
            .disposed(by: disposeBag)

        passwordTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.passwordTextPublishSubject)
            .disposed(by: disposeBag)

        confirmPasswordTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.confirmPasswordTextPublishSubject)
            .disposed(by: disposeBag)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    deinit {
        print("deinit from sign up coordinator")
    }

    @IBAction func tappedSignUpButton(_ sender: UIButton) {

    }

}
