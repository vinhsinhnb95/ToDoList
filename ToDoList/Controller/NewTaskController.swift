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
    @IBOutlet weak var tasktypePicker: UIPickerView!
    var taskTypes = TaskType.getAll()
    var currentTaskType: TaskType?
    var localNotification = LocalNotification.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        currentTaskType = taskTypes[0]

//      Set placehoder textView
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
        if let task = Task.insert(information: information, deadline: date) {
            currentTaskType?.addToTask(task)
            task.taskType = currentTaskType
            do {
                try AppDelegate.managedObjectContext?.save()
            } catch {
                print("Save error!!")
            }
        }
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
extension NewTaskController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taskTypes[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentTaskType = taskTypes[row]
    }

}
extension NewTaskController: UINavigationControllerDelegate {}
