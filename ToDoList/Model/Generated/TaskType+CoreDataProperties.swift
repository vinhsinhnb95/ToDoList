//
//  TaskType+CoreDataProperties.swift
//  ToDoList
//
//  Created by LTT on 8/13/18.
//  Copyright © 2018 LTT. All rights reserved.
//
//

import Foundation
import CoreData

extension TaskType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskType> {
        return NSFetchRequest<TaskType>(entityName: "TaskType")
    }

    @NSManaged public var name: String?
    @NSManaged public var task: NSSet?

}

// MARK: Generated accessors for task
extension TaskType {

    @objc(addTaskObject:)
    @NSManaged public func addToTask(_ value: Task)

    @objc(removeTaskObject:)
    @NSManaged public func removeFromTask(_ value: Task)

    @objc(addTask:)
    @NSManaged public func addToTask(_ values: NSSet)

    @objc(removeTask:)
    @NSManaged public func removeFromTask(_ values: NSSet)

    static func generateData() {
        if getAll().count == 0 {
            _ = TaskType.insert(name: "Personal")
            _ = TaskType.insert(name: "Work")
        }
    }

    func getNotCompleteTasks() -> [Task] {
        if var tasks = (self.task?.allObjects as? [Task])?.filter({ (task) -> Bool in
            return task.status == false
        }) {
            tasks = tasks.sorted(by: { (task1, task2) -> Bool in
                if task1.priority == true, task2.priority == false {
                    return true
                } else if task1.priority == false, task2.priority == true {
                    return false
                } else {
                    if let date1 = task1.deadline as? Date, let date2 = task2.deadline as? Date {
                        return date1 > date2
                    }
                    return false
                }
            })
            return tasks
        }
        return [Task]()
    }

    func getCompletedTasks() -> [Task] {
        if var tasks = (self.task?.allObjects as? [Task])?.filter({ (task) -> Bool in
            return task.status == true
        }) {
            tasks = tasks.sorted(by: { (task1, task2) -> Bool in
                if task1.priority == true, task2.priority == false {
                    return true
                } else if task1.priority == false, task2.priority == true {
                    return false
                } else {
                    if let date1 = task1.deadline as? Date, let date2 = task2.deadline as? Date {
                        return date1 > date2
                    }
                    return false
                }
            })
            return tasks
        }
        return [Task]()
    }

    static func insert(name: String) -> TaskType? {
        let taskType = NSEntityDescription.insertNewObject(forEntityName: "TaskType", into: AppDelegate.managedObjectContext!) as? TaskType
        taskType?.name = name
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("Cant insert task \(nserror)")
            return nil
        }
        print("Insert success!!")
        return taskType
    }

    static func delete(taskType: TaskType) {
        let context = AppDelegate.managedObjectContext
        if let tasks = taskType.task as? [Task] {
            for task in tasks {
                taskType.removeFromTask(task)
                context?.delete(task)
            }
        }
        context?.delete(taskType)
        do {
            try context?.save()
        } catch {
            print("Delete TaskType fail")
        }
    }

    static func getAll() -> [TaskType] {
        var result = [TaskType]()
        let context = AppDelegate.managedObjectContext
        do {
            result = (try context!.fetch(TaskType.fetchRequest()) as? [TaskType])!
        } catch {
            print("Cannot fetch \(error)")
        }
        return result
    }

}
