//
//  TaskController.swift
//  ToDoList
//
//  Created by LTT on 8/8/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class NewTaskController: UIViewController {

    @IBOutlet weak var informaintonField: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        informaintonField.delegate = self
        informaintonField.text = "Adding task"
        informaintonField.textColor = UIColor.lightGray

        datePicker.datePickerMode = .dateAndTime
    }

    @IBAction func confirmButtonPress(_ sender: Any) {
        guard let information = informaintonField.text, information.count != 0 else {
            self.present(Alert(message: "Dont have information").alert, animated: true, completion: nil)
            return
        }
        let date = datePicker.date as NSDate
        var _ = Task.insert(information: information, deadline: date)
        navigationController?.popViewController(animated: true)
    }

}

extension NewTaskController: UITextViewDelegate {
//    Logic place holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Adding task"
            textView.textColor = UIColor.lightGray
        }
    }
//    Setup done keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension NewTaskController: UINavigationControllerDelegate {}
