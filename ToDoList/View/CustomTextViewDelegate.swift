//
//  CustomTextViewDelegate.swift
//  ToDoList
//
//  Created by LTT on 8/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation
import UIKit

protocol CustomtextViewDelegate: UITextViewDelegate {}

extension CustomtextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
