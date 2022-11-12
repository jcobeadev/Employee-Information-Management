//
//  EmployeeCell.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class EmployeeCell: UITableViewCell {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var role: UILabel!

    func update(with viewModel: EmployeeCellViewModel) {
        fullName.text = viewModel.fullName
        role.text = viewModel.role
    }

}
