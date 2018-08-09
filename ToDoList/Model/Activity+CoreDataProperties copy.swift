//
//  Activity+CoreDataProperties.swift
//  
//
//  Created by LTT on 8/8/18.
//
//

import Foundation
import CoreData

extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var information: String?
    @NSManaged public var deadline: NSDate?
    @NSManaged public var status: Bool
    @NSManaged public var priority: Bool

    static func insert(information: String, deadline: NSDate ) -> Activity? {
        let activity = NSEntityDescription.insertNewObject(forEntityName: "Activity", into: AppDelegate.managedObjectContext!) as? Activity
        activity?.information = information
        activity?.deadline = deadline
        activity?.status = false
        activity?.priority = false
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("Cant insert activity \(nserror)")
            return nil
        }
        print("Insert success!!")
        return activity
    }

    static func update(activity: NSManagedObject, information: String, deadline: NSDate) {
        let activity = activity as? Activity
        activity?.information = information
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }

    static func checkComplete(activity: NSManagedObject) {
        let activity = activity as? Activity
        activity?.status = true
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }
    static func checkPiority(activity: NSManagedObject) {
        let activity = activity as? Activity
        if activity?.priority == true {
            activity?.priority = false
        } else {
            activity?.priority = true
        }
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            print("Cant update item")
        }
    }

    static func delete(activity: NSManagedObject) {
        let context = AppDelegate.managedObjectContext
        context?.delete(activity)
        do {
            try context?.save()
        } catch {
            print("Delete Item fail")
        }
    }

    static func getAll() -> [Activity] {
        var result = [Activity]()
        let context = AppDelegate.managedObjectContext
        do {
            result = (try context!.fetch(Activity.fetchRequest()) as? [Activity])!
        } catch {
            print("Cannot fetch \(error)")
        }
        return result
    }

    static func getAllNotComplete() -> [Activity] {
        let activities = self.getAll()
        return activities.filter({
            $0.status == false
        })
    }

    static func getAllCompleted() -> [Activity] {
        let activities = self.getAll()
        return activities.filter({
            $0.status == true
        })
    }

}
