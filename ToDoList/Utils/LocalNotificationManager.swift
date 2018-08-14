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

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (_, error) in
            if error == nil {
                print("permission granted")
            }
        }
    }

    func setTaskNotification (task: Task) {
//        Set content
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Deadline", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: task.information!, arguments: nil)

//        Set trigger
        var trigger: UNTimeIntervalNotificationTrigger?
        guard let timer = task.deadline?.timeIntervalSinceNow , timer > 0 else {
            return
        }
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: timer, repeats: false)

//        Create request
        if let idNotification = task.notificationID?.uuidString {
            let request = UNNotificationRequest(identifier: idNotification, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if error == nil {
                    print("Notification Success!!")
                }
            }
        }

    }
}
