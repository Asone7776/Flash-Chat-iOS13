//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var alert = ErrorAlert();
    var messages = [
        Message(sender: "test@gmail.com", body: "test"),
        Message(sender: "test1@gmail.com", body: "1234"),
        Message(sender: "test3@gmail.com", body: "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello")
    ]
    
    var barButtonItem:UIBarButtonItem {
        let button = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logout))
        return button;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        navigationItem.rightBarButtonItem = barButtonItem;
        navigationItem.hidesBackButton = true;
        title = Constants.appName;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier);
        alert.delegate = self;
    }
    
    @objc func logout(){
        do {
            try Auth.auth().signOut();
            navigationController?.popToRootViewController(animated: true);
        } catch let signOutError as NSError {
            alert.showAlert(title: "Error", message: signOutError.localizedDescription);
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
    }
    
    
}
extension ChatViewController:CanShowErrorAlert{
    func throwError(alert: UIAlertController) {
        present(alert,animated: true);
    }
}

extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell;
        cell.selectionStyle = .none;
        let body = messages[indexPath.row].body;
        cell.cellLabel.text = body;
        return cell;
    }
}
