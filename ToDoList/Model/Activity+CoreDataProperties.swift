//
//  Activity+CoreDataProperties.swift
//  ToDoList
//
//  Created by LTT on 8/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Task")
    }

    @NSManaged public var deadline: NSDate?
    @NSManaged public var information: String?
    @NSManaged public var priority: Bool
    @NSManaged public var status: Bool

}
