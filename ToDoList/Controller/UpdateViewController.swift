//
//  UpdateViewController.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var informationField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var confirmButton: UIButton!
    var activity: Activity?

    override func viewDidLoad() {
        super.viewDidLoad()
        if activity != nil {
            loadData()
        }
    }
    
    func  loadData() {
        informationField.text = activity?.information
        datePicker.date = activity?.deadline as! Date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmButtonPress(_ sender: Any) {
        let information = informationField.text!
        let date = datePicker.date as NSDate
        var _ = Activity.update(activity: activity!, information: information, deadline: date)
        navigationController?.popViewController(animated: true)
    }
}
extension UpdateViewController: UINavigationControllerDelegate {}
