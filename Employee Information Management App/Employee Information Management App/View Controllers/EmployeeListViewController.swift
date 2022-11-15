//
//  EmployeeListViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit
import RxSwift
import RxCocoa

final class EmployeeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: EmployeeListViewModel!
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupViews()
        bind()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            // viewModel.tappedLogout()
        }
    }

    @objc
    private func tappedAddEmployeeButton() {
        viewModel.tappedAddEmployee()
    }

    @objc
    private func tappedLogoutButton() {

        let alertController = UIAlertController(title: "Are you sure you wan't to logout?", message: nil, preferredStyle: .alert)
        let noAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        let logoutAlertAction = UIAlertAction(title: "Logout", style: .destructive) { [weak self] _ in
            self?.viewModel.tappedLogout { error in
                guard let error else { return }
                self?.presentErrorAlert(error)
            }
        }

        alertController.addAction(noAlertAction)
        alertController.addAction(logoutAlertAction)

        present(alertController, animated: true)
    }

}

extension EmployeeListViewController {
    private func setupViews() {
        let logoutImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        let logoutButtonItem = UIBarButtonItem(
            image: logoutImage,
            style: .plain,
            target: self,
            action: #selector(tappedLogoutButton)
        )
        logoutButtonItem.tintColor = .primary
        navigationItem.leftBarButtonItem = logoutButtonItem


        let plusImage = UIImage(systemName: "person.badge.plus")
        let barButtonItem = UIBarButtonItem(
            image: plusImage,
            style: .plain,
            target: self,
            action: #selector(tappedAddEmployeeButton)
        )
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem

        // navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
    }

    private func bind() {
        // Bind table view
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.employees.bind(to: tableView.rx.items(cellIdentifier: "EmployeeCell", cellType: EmployeeCell.self)) { row, item, cell in
            cell.update(with: EmployeeCellViewModel(employee: item))
        }.disposed(by: disposeBag)

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self else { return }
            self.viewModel.tappedItem(at: indexPath)
        }).disposed(by: disposeBag)
    }

}

extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
