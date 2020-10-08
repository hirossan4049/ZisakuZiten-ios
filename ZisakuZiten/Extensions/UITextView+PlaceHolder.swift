//
//  UITextView+PlaceHolder.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/08.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

/// FIXME: Extension
//extension UITextViewDelegate{
class PlaceHolder:UITextView, UITextViewDelegate{
 
//    private struct additional {
//        static var placeHolder: String = ""
//    }
//
//    var placeHolder: String {
//        get {
//            guard let theName = objc_getAssociatedObject(self, &additional.placeHolder) as? String else {
//                return ""
//            }
//            return theName
//        }
//        set {
//            objc_setAssociatedObject(self, &additional.placeHolder, newValue, .OBJC_ASSOCIATION_RETAIN)
//        }
//    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("TEXT VIEW")
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }

    
    open func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    open func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing")
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}

