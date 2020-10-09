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
    
    func toStringJapanese() -> String{
        let dateFomatter = DateFormatter()
        let calendar = Calendar.current
        let now = Date()
        var dateformatString = ""
        if calendar.component(.year, from: self) != calendar.component(.year, from: now){
            dateformatString = "yyyy年MM月dd日 HH:mm"
        }else{
            if calendar.component(.month, from: self) != calendar.component(.month, from: now){
                dateformatString = "MM月dd日 HH:mm"
            }else{
                if calendar.component(.day, from: self) != calendar.component(.day, from: now){
                    dateformatString = "dd日 HH:mm"
                }else{
                    dateformatString = "HH:mm"
                }
            }
        }
        dateFomatter.dateFormat = dateformatString
        return dateFomatter.string(from: self)
    }
}
