//
//  CompletedTaskViewController.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class CompletedTaskViewController: UIViewController {
    var taskTypes: [TaskType]!

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTypes = TaskType.getAll()
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = taskTypes[indexPath.section].getCompletedTasks()[indexPath.row]
            taskTypes[indexPath.section].removeFromTask(task)
            Task.delete(task: task)
            taskTypes = TaskType.getAll()
            tableView.reloadData()
        }
    }
}

extension CompletedTaskViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskTypes.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTypes[section].getCompletedTasks().count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return taskTypes[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTaskCell", for: indexPath) as! CompletedTaskCell
        let task = taskTypes[indexPath.section].getCompletedTasks()[indexPath.row]
        cell.task = task
        return cell
    }
}
