//
//  ActivityCell.swift
//  ToDoList
//
//  Created by LTT on 8/8/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var informationField: UILabel!
    @IBOutlet weak var heartImage: UIButton!
    @IBOutlet weak var actionButtonGroup: UIView!
    @IBOutlet weak var heightConstrant: NSLayoutConstraint!
    @IBOutlet weak var setTimeButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    var isExpanded: Bool = false {
        didSet {
            if !isExpanded {
                self.heightConstrant.constant = 0.0
                setTimeButton.isHidden = true
                checkButton.isHidden = true
                deleteButton.isHidden = true
            } else {
                self.heightConstrant.constant = 98.0
                setTimeButton.isHidden = false
                checkButton.isHidden = false
                deleteButton.isHidden = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        heartImage.isUserInteractionEnabled = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func config(activity: Activity) {
        informationField.text = activity.information
        let date = activity.deadline! as Date
        dateLabel.text = Date.toString(date)()
        if activity.priority == false {
            heartImage.setImage(UIImage(named: "empty-heart"), for: .normal)
        } else {
            heartImage.setImage(UIImage(named: "filled-heart"), for: .normal)
        }

    }

}
