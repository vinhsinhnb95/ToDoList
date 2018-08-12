//
//  CompletedTaskCell.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class CompletedTaskCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!

    var task: Task? {
        didSet {
            informationLabel.text = task?.information
            let date = task?.deadline! as! Date
            dateLabel.text = Date.toString(date)()
            if task?.priority == true {
                heartImage.image = UIImage(named: "filled-heart")
            } else {
                heartImage.image = UIImage(named: "empty-heart")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
