//
//  NewTypeViewController.swift
//  ToDoList
//
//  Created by LTT on 8/14/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class NewTypeViewController: UIViewController {

    @IBOutlet weak var typeField: UITextField!
    var delegate: MainViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmButtonPress(_ sender: Any) {
        if let type = typeField.text, type.count > 0 {
            _ = TaskType.insert(name: type)
            delegate?.reloadView()
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func cancelButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
