//
//  FormViewController.swift
//  TestProject
//
//  Created by Luca Schifino on 26/08/18.
//  Copyright © 2018 Luca Schifino. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.addTarget(self, action: #selector(self.textFieldEditingChanged), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var ageTextField: UITextField! {
        didSet {
            ageTextField.delegate = self
            ageTextField.addTarget(self, action: #selector(self.textFieldEditingChanged), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var okButton: UIButton! {
        didSet {
            okButton.isEnabled = false
        }
    }
    
    @IBOutlet weak var cleanFieldsButton: UIButton! {
        didSet {
            cleanFieldsButton.isEnabled = false
        }
    }
    
    //MARK: - Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let appName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String {
            self.title = appName
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Custom Methods
    @objc func textFieldEditingChanged() {
        let nameWritten = (self.nameTextField.text?.count ?? 0) > 0
        let ageWritten = (self.ageTextField.text?.count ?? 0) > 0
        okButton.isEnabled = nameWritten && ageWritten
        cleanFieldsButton.isEnabled = nameWritten || ageWritten
    }
    
    
    @IBAction func showModalViewController(_ sender: Any) {
        guard let name = nameTextField.text, name != "",
            let age = ageTextField.text, age != ""  else {
                self.showError(title: R.string.localizable.emptyFieldMessage(),
                               message: nil)
                return
        }
        let user = User(name: name, age: age)
        guard let userInfoVC = UserInfoViewController.instantiate(withUser: user) else {
            self.showError(title: R.string.localizable.genericErrorMessage(),
                           message: nil)
            return
        }
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    @IBAction func cleanTextFields(_ sender: Any) {
        self.nameTextField.text = ""
        self.ageTextField.text = ""
    }
}

//MARK: - UITextFieldDelegate
extension FormViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.nameTextField {
            return textField.text!.count < 50 || string == ""
        } else if textField == self.ageTextField {
            return textField.text!.count < 3 || string == ""
        }
        return true
    }
}
