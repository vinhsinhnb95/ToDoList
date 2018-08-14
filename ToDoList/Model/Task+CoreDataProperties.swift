//
//  Task+CoreDataProperties.swift
//  ToDoList
//
//  Created by LTT on 8/14/18.
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

}
