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
    var indexPath: IndexPath?
    var expandedRows = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Task.getAllNotComplete()
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        tasks = Task.getAllNotComplete()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func deleteButtonPress(_ sender: Any) {
        if let taskSelected = taskSelected {
            Task.delete(task: taskSelected)
            tasks = Task.getAllNotComplete()
            tableView.reloadData()
            tableView(tableView, didDeselectRowAt: indexPath!)
        }
    }

    @IBAction func checkButtonPress(_ sender: Any) {
        if let taskSelected = taskSelected {
            Task.checkComplete(task: taskSelected)
            tasks = Task.getAllNotComplete()
            tableView.reloadData()
            tableView(tableView, didDeselectRowAt: indexPath!)
        }
    }

    @IBAction func checkPiorityPress(_ sender: Any) {
        if let taskSelected = taskSelected {
            Task.checkPiority(task: taskSelected)
            tasks = Task.getAllNotComplete()
            tableView.reloadData()
            tableView(tableView, didDeselectRowAt: indexPath!)
        }
    }

    @IBAction func updateButtonPress(_ sender: Any) {
        tableView(tableView, didDeselectRowAt: indexPath!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TaskInformation" {
            if let destination = segue.destination as? UpdateTaskViewController {
                destination.task = taskSelected
            }
        }
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
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        return cell
    }

}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 198
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskSelected = tasks[indexPath.row]
        self.indexPath = indexPath
        guard let cell = tableView.cellForRow(at: indexPath) as? TaskCell
            else { return }

        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        cell.isExpanded = !cell.isExpanded
        self.tableView.beginUpdates()
        self.tableView.endUpdates()

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        taskSelected = nil
        guard let cell = tableView.cellForRow(at: indexPath) as? TaskCell
            else { return }

        self.expandedRows.remove(indexPath.row)
        cell.isExpanded = false

        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
