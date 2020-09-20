//
//  String+leftPadding.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/20.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation

extension String {

      func leftPadding(toLength: Int, withPad: String) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeating:withPad, count: toLength - stringLength) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}  
