//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotification {
    static var shared = LocalNotification()
    let center = UNUserNotificationCenter.current()

    func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .sound]) { (_, error) in
            if error == nil {
                print("permission granted")
            }
        }
    }

    func sendLocalNotification (in time: TimeInterval, task: Task) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Deadline", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: task.information!, arguments: nil)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: trigger)
        center.add(request) { error in
            if error == nil {
                print("Success!!")
            }
        }

    }
}
