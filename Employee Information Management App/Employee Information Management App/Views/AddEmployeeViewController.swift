//
//  AddEmployeeViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class AddEmployeeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: AddEmployeeViewModel!

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    deinit {
        print("deinit from add employee view controller")
    }
}
