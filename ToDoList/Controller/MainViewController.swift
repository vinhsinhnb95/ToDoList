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
    @IBOutlet weak var activityTableView: UITableView!
    var activities: [Activity]!
    var activitySelected: Activity?
    var indexPath: IndexPath?
    var expandedRows = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        activities = Activity.getAllNotComplete()
        self.activityTableView.rowHeight = UITableViewAutomaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        activities = Activity.getAllNotComplete()
        activityTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func deleteButtonPress(_ sender: Any) {
        if let activitySelected = activitySelected {
            Activity.delete(activity: activitySelected)
            activities = Activity.getAllNotComplete()
            activityTableView.reloadData()
            tableView(activityTableView, didDeselectRowAt: indexPath!)
        }
    }

    @IBAction func checkButtonPress(_ sender: Any) {
        if let activitySelected = activitySelected {
            Activity.checkComplete(activity: activitySelected)
            activities = Activity.getAllNotComplete()
            activityTableView.reloadData()
            tableView(activityTableView, didDeselectRowAt: indexPath!)
        }
    }

    @IBAction func checkPiorityPress(_ sender: Any) {
        if let activitySelected = activitySelected {
            Activity.checkPiority(activity: activitySelected)
            activities = Activity.getAllNotComplete()
            activityTableView.reloadData()
            tableView(activityTableView, didDeselectRowAt: indexPath!)
        }
    }

    @IBAction func updateButtonPress(_ sender: Any) {
        tableView(activityTableView, didDeselectRowAt: indexPath!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activityInformation" {
            if let destination = segue.destination as? UpdateViewController {
                destination.activity = activitySelected
            }
        }
    }

}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        let activity = activities[indexPath.row]
        cell.config(activity: activity)
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        return cell
    }

}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 198
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activitySelected = activities[indexPath.row]
        self.indexPath = indexPath
        guard let cell = tableView.cellForRow(at: indexPath) as? ActivityCell
            else { return }

        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        cell.isExpanded = !cell.isExpanded
        self.activityTableView.beginUpdates()
        self.activityTableView.endUpdates()

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        activitySelected = nil
        guard let cell = tableView.cellForRow(at: indexPath) as? ActivityCell
            else { return }

        self.expandedRows.remove(indexPath.row)
        cell.isExpanded = false

        self.activityTableView.beginUpdates()
        self.activityTableView.endUpdates()
    }
}
