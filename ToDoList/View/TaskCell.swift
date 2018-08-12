//
//  TaskCell.swift
//  ToDoList
//
//  Created by LTT on 8/8/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

protocol TaskCellDelegate {
    func setPiority(indexPath: IndexPath)
    func setComplete(indexPath: IndexPath)
    func updateTask(indexPath: IndexPath)
    func deleteTask(indexPath: IndexPath)
}

class TaskCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var informationField: UILabel!
    @IBOutlet weak var setPiorityButton: UIButton!
    @IBOutlet weak var actionButtonGroup: UIView!
    @IBOutlet weak var heightConstrant: NSLayoutConstraint!
    @IBOutlet weak var updateTaskButton: UIButton!
    @IBOutlet weak var setCompleteButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    var delegate: TaskCellDelegate?
    var indexPath: IndexPath?

    var task: Task? {
        didSet {
            informationField.text = task?.information
            let date = task?.deadline! as! Date
            dateLabel.text = Date.toString(date)()
            if task?.priority == false {
                setPiorityButton.setImage(UIImage(named: "empty-heart"), for: .normal)
            } else {
                setPiorityButton.setImage(UIImage(named: "filled-heart"), for: .normal)
            }
        }
    }

    var isExpanded: Bool = false {
        didSet {
            if !isExpanded {
                self.heightConstrant.constant = 0.0
                updateTaskButton.isHidden = true
                setCompleteButton.isHidden = true
                deleteButton.isHidden = true
            } else {
                self.heightConstrant.constant = 98.0
                updateTaskButton.isHidden = false
                setCompleteButton.isHidden = false
                deleteButton.isHidden = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func setPiorityButtonPress(_ sender: Any) {
        delegate?.setPiority(indexPath: indexPath!)
    }

    @IBAction func updateTaskButtonPress(_ sender: Any) {
        delegate?.updateTask(indexPath: indexPath!)
    }

    @IBAction func setCompleteButtonPress(_ sender: Any) {
        delegate?.setComplete(indexPath: indexPath!)
    }
    @IBAction func deleteButtonPress(_ sender: Any) {
        delegate?.deleteTask(indexPath: indexPath!)
    }

}
