//
//  LoginViewController.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

final class LoginViewController: UIViewController {

    static func instantiate() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return controller
    }

}
