//
//  EmployeeListViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class EmployeeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: EmployeeListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupViews()
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

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            print("viewDidDisappear isMovingFromParent")
            viewModel.tappedLogout()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            print("viewWillDisappear isMovingFromParent")
        }
    }


    @objc
    private func tappedAddEmployeeButton() {
        viewModel.tappedAddEmployee()
    }

    deinit {
        print("deinit from employee view controller")
    }

}

extension EmployeeListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        cell.update(with: viewModel.cellViewModel(at: indexPath))
        return cell
    }

}
extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
