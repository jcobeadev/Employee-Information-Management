//
//  SignUpViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class SignUpViewController: UIViewController {

    var viewModel: SignUpViewModel!

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    deinit {
        print("deinit from sign up coordinator")
    }

}
