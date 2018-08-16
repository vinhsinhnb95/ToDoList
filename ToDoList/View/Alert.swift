//
//  Alert.swift
//  ToDoList
//
//  Created by LTT on 8/9/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import UIKit

class Alert {

    var alert: UIAlertController

    init(message: String) {
        alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
    }
}
