//
//  String+toDate.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/12.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation


extension String{
    func toDate() -> Date{
        let dateFomatter = DateFormatter()
        // フォーマット設定
        dateFomatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.dateFormat = "yyyyMMddHHmmssSSS" // ミリ秒込み

        // ロケール設定（端末の暦設定に引きづられないようにする）
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        // タイムゾーン設定（端末設定によらず、どこの地域の時間帯なのかを指定する）
//        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        //dateFormatter.timeZone = TimeZone(identifier: "Etc/GMT") // 世界標準時

        // 変換
        return dateFomatter.date(from: self)!
        //let date = dateFormatter.date(from: "20201020112233456") // ミリ秒込み

        // 結果表示
        
    }
}
