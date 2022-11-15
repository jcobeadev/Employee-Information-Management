//
//  String+Extensions.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/15/22.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let predicate: NSPredicate = .init(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return predicate.evaluate(with: self)
    }
}
