//
//  ActivityController.swift
//  ToDoList
//
//  Created by LTT on 8/8/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class ActivityController: UIViewController {

    @IBOutlet weak var informaintonField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        informaintonField.becomeFirstResponder()
        datePicker.datePickerMode = .dateAndTime
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        datePicker.datePickerMode = .dateAndTime
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmButtonPress(_ sender: Any) {
        guard let information = informaintonField.text, information.count != 0 else {
            self.present(Alert(message: "Dont have information").alert, animated: true, completion: nil)
            return
        }
        let date = datePicker.date as NSDate
        var _ = Activity.insert(information: information, deadline: date)
        navigationController?.popViewController(animated: true)
    }

}

extension ActivityController: UINavigationControllerDelegate {}
