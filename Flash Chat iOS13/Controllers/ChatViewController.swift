//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var alert = ErrorAlert();
    let db = Firestore.firestore();
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
        loadData();
        navigationItem.rightBarButtonItem = barButtonItem;
        navigationItem.hidesBackButton = true;
        title = Constants.appName;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier);
        alert.delegate = self;
    }
    
    func loadData (){
        db.collection(Constants.FStore.collectionName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                self.alert.showAlert(title: "Error", message: err.localizedDescription);
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data();
                    print(data);
                }
            }
        }
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
        if let body = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.bodyField:body,
                Constants.FStore.senderField:messageSender
            ]) { error in
                if let e = error{
                    self.alert.showAlert(title: "Error", message: e.localizedDescription);
                }
            }
        }
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
