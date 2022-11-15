//
//  UIViewController+Extensions.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

extension UIViewController {
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "\(T.self)") as! T
        return controller
    }

    func presentErrorAlert(_ error: Error) {
        let alertController = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(firstAction)
        present(alertController, animated: true)
    }
}
