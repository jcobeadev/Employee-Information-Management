//
//  AddEmployeeViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit
import RxSwift
import RxCocoa

final class AddEmployeeViewController: UIViewController {
    
    var viewModel: AddEmployeeViewModel!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!

    var doneBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    @objc
    private func tappedDone() {
        viewModel.tappedDoneButton { [weak self] error in
            guard let error else { return }
            self?.presentErrorAlert(error)
        }
    }

    @objc
    private func tappedCancel() {
        dismiss(animated: true)
    }
}

extension AddEmployeeViewController {
    private func setupViews() {
        // navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
        navigationItem.rightBarButtonItem = doneBarButtonItem
        //UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tappedCancel))
    }
}

extension AddEmployeeViewController {
    private func bind() {
        firstNameTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.firstName)
            .disposed(by: disposeBag)

        lastNameTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.lastName)
            .disposed(by: disposeBag)

        roleTextField
            .rx.text.map { $0 ?? "" }
            .bind(to: viewModel.role)
            .disposed(by: disposeBag)

        viewModel.isValidInput.bind(to: doneBarButtonItem.rx.isEnabled).disposed(by: disposeBag)

    }
}
