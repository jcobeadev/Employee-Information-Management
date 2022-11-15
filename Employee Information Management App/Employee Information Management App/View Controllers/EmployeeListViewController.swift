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
        print("deinit from employee viewcontroller")
    }

}

extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
