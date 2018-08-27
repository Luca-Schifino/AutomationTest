//
//  UIViewController+Error.swift
//  TestProject
//
//  Created by Luca Schifino on 26/08/18.
//  Copyright © 2018 Luca Schifino. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(title: String, message: String?, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: R.string.localizable.ok().uppercased(), style: .cancel, handler: actionHandler)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
