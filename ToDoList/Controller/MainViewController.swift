//
//  ViewController.swift
//  ToDoList
//
//  Created by LTT on 8/8/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var taskTypes: [TaskType]!
    var currentIndexPath: IndexPath?
    var localNotification = LocalNotification.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTypes = TaskType.getAll()
        TaskType.generateData()

//        Set notification
        localNotification.requestAuthorization()

        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        taskTypes = TaskType.getAll()
        tableView.reloadData()
    }

    func collapsedCurrent() {
        if let cell = tableView.cellForRow(at: currentIndexPath!) as? TaskCell {
            cell.isExpanded = false
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TaskInformation" {
            if let destination = segue.destination as? UpdateTaskViewController,
                let task = sender as? Task {
                destination.task = task
            }
        }
    }

}
extension MainViewController: TaskCellDelegate {
    func setPiority(indexPath: IndexPath) {
        let task = taskTypes[indexPath.section].getNotCompleteTasks()[indexPath.row]
        Task.setPiority(task: task)
        taskTypes = TaskType.getAll()
        tableView.reloadData()
    }

    func setComplete(indexPath: IndexPath) {
        let task = taskTypes[indexPath.section].getNotCompleteTasks()[indexPath.row]
        Task.setComplete(task: task)
        taskTypes = TaskType.getAll()
        tableView.reloadData()
    }

    func updateTask(indexPath: IndexPath) {
        let task = taskTypes[indexPath.section].getNotCompleteTasks()[indexPath.row]
        performSegue(withIdentifier: "TaskInformation", sender: task)
    }

    func deleteTask(indexPath: IndexPath) {
        let task = taskTypes[indexPath.section].getNotCompleteTasks()[indexPath.row]
        taskTypes[indexPath.section].removeFromTask(task)
        Task.delete(task: task)
        taskTypes = TaskType.getAll()
        tableView.reloadData()
    }

}
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskTypes.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTypes[section].getNotCompleteTasks().count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let tasks = taskTypes[indexPath.section].getNotCompleteTasks()
        let task = tasks[indexPath.row]
        cell.task = task
        cell.delegate = self
        cell.indexPath = indexPath
        cell.isExpanded = false
        return cell
    }

}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        tableView.estimatedRowHeight = tableView.rowHeight
//        return UITableViewAutomaticDimension
        return 135
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return taskTypes[section].name
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TaskCell else {
            return
        }
        if let _ = self.currentIndexPath {
            if currentIndexPath != indexPath {
                collapsedCurrent()
                currentIndexPath = indexPath
                cell.isExpanded = true
            } else {
                cell.isExpanded = !cell.isExpanded
            }
        } else {
//        No cell selected
            currentIndexPath = indexPath
            cell.isExpanded = true
        }
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

extension MainViewController: UNUserNotificationCenterDelegate {
//    Show notification on foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
