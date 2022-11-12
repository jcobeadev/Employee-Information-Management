//
//  EmployeeListViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class EmployeeListViewController: UIViewController {

//    private let localDataManager = LocalDataManager()
    var viewModel: EmployeeListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

//        localDataManager.registerCompany(
//            userName: "Collabera",
//            email: "collabera@gmail.com",
//            password: "password")
//
//        print(localDataManager.fetchCompanies())
    }

    private func setupViews() {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(
            image: plusImage,
            style: .plain,
            target: self,
            action: #selector(tappedAddEmployeeButton)
        )
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc
    private func tappedAddEmployeeButton() {
        viewModel.tappedAddEmployee()
    }

}
