//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Arthur Obichkin on 23/01/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellVIew: UIView!
    @IBOutlet weak var youImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellVIew.layer.cornerRadius = 8;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
