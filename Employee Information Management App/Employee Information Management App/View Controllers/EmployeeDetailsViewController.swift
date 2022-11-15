//
//  EmployeeDetailsViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import UIKit

final class EmployeeDetailsViewController: UIViewController {

    var viewModel: EmployeeDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisAppear()
    }


    deinit {
        print("deinit EmployeeDetailsViewController")
    }

}
