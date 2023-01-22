//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var alert = ErrorAlert();
    override func viewDidLoad() {
        alert.delegate = self;
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text else {
            return;
        }
        guard let password = passwordTextfield.text else {
            return;
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.alert.showAlert(title: "Error", message: error.localizedDescription);
            }else{
                self.performSegue(withIdentifier: Constants.registerSegue, sender: self);
            }
        }
    }
    
}

extension RegisterViewController:CanShowErrorAlert{
    func throwError(alert: UIAlertController) {
        present(alert,animated: true);
    }
}
