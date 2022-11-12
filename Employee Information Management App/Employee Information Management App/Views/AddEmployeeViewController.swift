//
//  AddEmployeeViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class AddEmployeeViewController: UIViewController {
    
    var viewModel: AddEmployeeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    deinit {
        print("deinit from add employee view controller")
    }

    @objc
    private func tappedDone() {
        print("tapped done.")
    }
}
