//
//  Date+toString.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/25.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation

extension Date{
    func toString() -> String{
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFomatter.string(from: self)
    }
}
