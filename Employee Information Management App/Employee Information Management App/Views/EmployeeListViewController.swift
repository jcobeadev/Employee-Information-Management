//
//  EmployeeListViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class EmployeeListViewController: UIViewController {

    static func instantiate() -> EmployeeListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmployeeListViewController") as! EmployeeListViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        let plusImage = UIImage(named: "plus.circle")
        let barButtonItem = UIBarButtonItem(
            image: plusImage,
            style: .plain,
            target: self,
            action: #selector(tappedRightBarButton)
        )
        navigationItem.rightBarButtonItem = barButtonItem
        #warning("Add property to view model")
        navigationItem.title = "Employees"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc
    private func tappedRightBarButton() {
        print("bar button item is tapped.")
    }

}
