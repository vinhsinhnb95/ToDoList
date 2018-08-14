//
//  UpdateViewController.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class UpdateTaskViewController: UIViewController {

    @IBOutlet weak var informationField: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var confirmButton: UIButton!
    var task: Task?
    var taskTypes = TaskType.getAll()

    override func viewDidLoad() {
        super.viewDidLoad()
        informationField.delegate = self
        if task != nil {
            loadData()
        }
    }
    func loadData() {
        informationField.text = task?.information
        datePicker.date = (task?.deadline as? Date) ?? Date()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmButtonPress(_ sender: Any) {
        guard let information = informationField.text, information.count != 0 else {
            self.present(Alert(message: "Dont have information").alert, animated: true, completion: nil)
            return
        }
        let date = datePicker.date as NSDate
        var _ = Task.update(task: task!, information: information, deadline: date)
        navigationController?.popViewController(animated: true)
    }

}
extension UpdateTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
    }
}
extension UpdateTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UpdateTaskViewController: UITextViewDelegate {
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
extension UpdateTaskViewController: UINavigationControllerDelegate {}
