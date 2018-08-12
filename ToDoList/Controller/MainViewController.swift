//
//  ViewController.swift
//  ToDoList
//
//  Created by LTT on 8/8/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var tasks: [Task]!
    var taskSelected: Task?
    var currentIndexPath: IndexPath?
    var expandedRows = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Task.getAllNotComplete()
//        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        tasks = Task.getAllNotComplete()
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
                let task = sender as? Task{
                destination.task = task
            }
        }
    }

}
extension MainViewController: TaskCellDelegate {
    func setPiority(indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        Task.checkPiority(task: task)
        tasks = Task.getAllNotComplete()
        tableView.reloadData()
        collapsedCurrent()
    }

    func setComplete(indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        Task.checkComplete(task: task)
        tasks = Task.getAllNotComplete()
        tableView.reloadData()
        collapsedCurrent()
    }

    func updateTask(indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        performSegue(withIdentifier: "TaskInformation", sender: task)
        collapsedCurrent()
    }

    func deleteTask(indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        Task.delete(task: task)
        tasks = Task.getAllNotComplete()
        tableView.reloadData()
        collapsedCurrent()
    }

}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
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
        tableView.estimatedRowHeight = tableView.rowHeight
        return UITableViewAutomaticDimension
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
