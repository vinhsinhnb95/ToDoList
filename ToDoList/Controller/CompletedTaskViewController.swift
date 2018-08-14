//
//  CompletedTaskViewController.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class CompletedTaskViewController: UIViewController {
    var tasksType: [TaskType]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tasksType = TaskType.getAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CompletedTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
}

extension CompletedTaskViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasksType.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksType[section].getCompletedTasks().count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tasksType[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTaskCell", for: indexPath) as! CompletedTaskCell
        let task = tasksType[indexPath.section].getCompletedTasks()[indexPath.row]
        cell.task = task
        return cell
    }
}
