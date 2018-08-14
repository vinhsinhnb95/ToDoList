//
//  Task+CoreDataProperties.swift
//  ToDoList
//
//  Created by LTT on 8/13/18.
//  Copyright © 2018 LTT. All rights reserved.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var deadline: NSDate?
    @NSManaged public var information: String?
    @NSManaged public var priority: Bool
    @NSManaged public var status: Bool
    @NSManaged public var notificationID: UUID?
    @NSManaged public var taskType: TaskType?

    static func insert(information: String, deadline: NSDate) -> Task? {
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: AppDelegate.managedObjectContext!) as? Task
        task?.information = information
        task?.deadline = deadline
        task?.status = false
        task?.priority = false
        task?.notificationID = UUID()
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("Cant insert task \(nserror)")
            return nil
        }
        LocalNotification.shared.setTaskNotification(task: task!)
        print("Insert success!!")
        return task
    }

    static func update(task: NSManagedObject, information: String, deadline: NSDate) {
        let task = task as? Task
        task?.information = information
        task?.deadline = deadline
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }

    static func setComplete(task: NSManagedObject) {
        let task = task as? Task
        task?.status = true
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }

    static func setPiority(task: NSManagedObject) {
        let task = task as? Task
        if task?.priority == true {
            task?.priority = false
        } else {
            task?.priority = true
        }
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }

    static func delete(task: NSManagedObject) {
        let context = AppDelegate.managedObjectContext
        context?.delete(task)
        do {
            try context?.save()
        } catch {
            print("Delete Item fail")
        }
    }

    static func getAll() -> [Task] {
        var result = [Task]()
        let context = AppDelegate.managedObjectContext
        do {
            result = (try context!.fetch(Task.fetchRequest()) as? [Task])!
        } catch {
            print("Cannot fetch \(error)")
        }
        return result
    }

    static func getAllNotComplete() -> [Task] {
        let activities = self.getAll()
        return activities.filter({
            $0.status == false
        })
    }

    static func getAllCompleted() -> [Task] {
        let task = self.getAll()
        return task.filter({
            $0.status == true
        })
    }

}
