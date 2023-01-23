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
    var messages:[Message] = [];
    
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
    
    func updateTable (){
        tableView.reloadData();
        let indexPath = IndexPath(item: self.messages.count - 1, section: 0);
        tableView.scrollToRow(at: indexPath, at: .top, animated: true);
    }
    
    func loadData (){
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener() { (querySnapshot, err) in
            self.messages = [];
            if let err = err {
                if Auth.auth().currentUser != nil{
                    self.alert.showAlert(title: "Error", message: err.localizedDescription);
                }else{
                    print(err.localizedDescription);
                }
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data();
                    if let sender = data[Constants.FStore.senderField] as? String,  let body = data[Constants.FStore.bodyField] as? String{
                        let message = Message(sender: sender, body: body);
                        self.messages.append(message);
                    }
                }
                self.updateTable();
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
            self.messageTextfield.text = "";
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.bodyField:body,
                Constants.FStore.senderField:messageSender,
                Constants.FStore.dateField:Date().timeIntervalSince1970
            ],completion: { error in
                if let e = error{
                    self.alert.showAlert(title: "Error", message: e.localizedDescription);
                }
            });
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
        let message = messages[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell;
        cell.selectionStyle = .none;
        let body = messages[indexPath.row].body;
        cell.cellLabel.text = body;
        if message.sender == Auth.auth().currentUser?.email{
            cell.youImage.isHidden = true;
            cell.cellImage.isHidden = false;
            cell.cellVIew.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple);
            cell.cellLabel.textColor = UIColor(named: Constants.BrandColors.purple);
        }else{
            cell.youImage.isHidden = false;
            cell.cellImage.isHidden = true;
            cell.cellVIew.backgroundColor = UIColor(named: Constants.BrandColors.purple);
            cell.cellLabel.textColor = UIColor(named: Constants.BrandColors.lightPurple);
        }
        return cell;
    }
}
