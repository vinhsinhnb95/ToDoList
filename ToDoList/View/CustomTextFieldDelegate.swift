//
//  CustomTextFieldDelegate.swift
//  ToDoList
//
//  Created by LTT on 8/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import UIKit

protocol CustomTextFieldDelegate: UITextFieldDelegate { }

extension CustomTextFieldDelegate {

//    Set done keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

