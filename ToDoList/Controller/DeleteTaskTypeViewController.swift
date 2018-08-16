//
//  DeleteTaskTypeViewController.swift
//  ToDoList
//
//  Created by LTT on 8/15/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import DropDown

class DeleteTaskTypeViewController: UIViewController {

    @IBOutlet weak var dropDownButton: UIButton!

    let dropDown = DropDown()
    let taskTypes = TaskType.getAll()
    var types = [String]()
    var currentTaskType: TaskType?
    var delegate: MainViewDelegate?

    func setupDropDown() {
        dropDown.anchorView = dropDownButton

        dropDown.bottomOffset = CGPoint(x: 0, y: dropDownButton.bounds.height)
        dropDown.dataSource = types

        dropDown.dismissMode = .onTap
        dropDown.direction = .any

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.currentTaskType = self.taskTypes[index]
            self.dropDownButton.setTitle(self.currentTaskType?.name, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        for type in taskTypes {
            types.append(type.name!)
        }
        setupDropDown()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseButtonPress(_ sender: Any) {
        dropDown.show()
    }

    @IBAction func confirmButtonPress(_ sender: Any) {
        if let currentTaskType = self.currentTaskType {
            TaskType.delete(taskType: currentTaskType)
            delegate?.reloadView()
            dismiss(animated: true, completion: nil)
        } else {
            self.present(Alert(message: "Must choose task type").alert, animated: true, completion: nil)
            return
        }
    }

    @IBAction func backButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
