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
import UserNotifications

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
        print("Insert success!!")
        LocalNotification.shared.setTaskNotification(task: task!)
        return task
    }

    static func update(task: Task, information: String, deadline: NSDate) {
//      remove old notification
        if let notificationID = task.notificationID?.uuidString {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationID])
        }

//      update new information
        task.information = information
        task.deadline = deadline

//      create new notification
        LocalNotification.shared.setTaskNotification(task: task)

        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }

    static func setComplete(task: Task) {
        task.status = true
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }

    static func setPiority(task: Task) {
        if task.priority == true {
            task.priority = false
        } else {
            task.priority = true
        }
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }

    static func delete(task: Task) {
//        Delete task's notification
        if let notificationId = task.notificationID?.uuidString {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationId])
        }
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
