//
//  CompletedActivityCell.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class CompletedActivityCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(activity: Activity) {
        informationLabel.text = activity.information
        let date = activity.deadline! as Date
        dateLabel.text = Date.toString(date)()
        if activity.priority == true {
            heartImage.image = UIImage(named: "filled-heart")
        } else {
            heartImage.image = UIImage(named: "empty-heart")
        }
    }

    

}
