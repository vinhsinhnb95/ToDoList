//
//  UpdateViewController.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class UpdateTaskViewController: UIViewController {

    @IBOutlet weak var informationField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var confirmButton: UIButton!
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        informationField.delegate = self
        if task != nil {
            loadData()
        }
    }
    func  loadData() {
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
extension UpdateTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension UpdateTaskViewController: UINavigationControllerDelegate {}
