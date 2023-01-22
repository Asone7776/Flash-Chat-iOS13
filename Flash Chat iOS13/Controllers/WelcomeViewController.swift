//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        titleLabel.text = "⚡️FlashChat";
//        animateTitle();
//        for (index,letter) in flash.enumerated() {
//            print("\(index)-\(letter)");
//        }
     
        
    }
//    func animateTitle (){
//        titleLabel.text = "";
//        var charIndex = 0.0;
//        flash.forEach { item in
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
//                self.titleLabel.text?.append(item);
//            }
//            charIndex += 1;
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "test"{
//            var destinationVc = segue.destination as !LoginViewController();
//            destinationVc.
//        }
//    }
}

