//
//  Helpers.swift
//  Flash Chat iOS13
//
//  Created by Arthur Obichkin on 22/01/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

protocol CanShowErrorAlert{
    func throwError(alert:UIAlertController);
}

struct ErrorAlert {
    var delegate:CanShowErrorAlert?;
    
    func showAlert (title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let action = UIAlertAction(title: "Close", style: .cancel);
        alert.addAction(action);
        delegate?.throwError(alert: alert);
    }
}
