//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var alert = ErrorAlert();
    override func viewDidLoad() {
        alert.delegate = self;
        emailTextfield.text = "test@gmail.com";
        passwordTextfield.text = "3258241";
    }
    let segueID = "LoginToChat";
    

    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text else {
            return;
        }
        guard let password = passwordTextfield.text else {
            return;
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.alert.showAlert(title: "Error", message: error.localizedDescription);
            }else{
                strongSelf.performSegue(withIdentifier: Constants.loginSegue, sender: self);
            }
        }
    }
    
}

extension LoginViewController:CanShowErrorAlert{
    func throwError(alert: UIAlertController) {
        present(alert,animated: true);
    }
}
