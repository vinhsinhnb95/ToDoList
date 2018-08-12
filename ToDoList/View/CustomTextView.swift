//
//  CustomTextView.swift
//  ToDoList
//
//  Created by LTT on 8/12/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
protocol CustomtextViewDelegate: UITextViewDelegate {}

extension CustomtextViewDelegate {

//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//
//        if text == "\n" {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }

    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }

}

class CustomTextView: UITextView {
    var customTextViewDelegate: CustomtextViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.text = "Placeholder"
        self.textColor = UIColor.lightGray
    }
}
