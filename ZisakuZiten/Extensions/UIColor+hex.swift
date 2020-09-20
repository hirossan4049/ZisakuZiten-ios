//
//  UIColor+hex.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/25.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

//hex UIColor
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }

    func toHexString() -> String {
        var red: CGFloat     = 1.0
        var green: CGFloat   = 1.0
        var blue: CGFloat    = 1.0
        var alpha: CGFloat   = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        print(Int(red*255),Int(green*255),Int(blue*255))
        
        // FIXME
        let r = Int(String(Int(floor(red*100)/100 * 255)).replacingOccurrences(of: "-", with: ""))!
        let g = Int(String(Int(floor(green*100)/100 * 255)).replacingOccurrences(of: "-", with: ""))!
        let b = Int(String(Int(floor(blue*100)/100 * 255)).replacingOccurrences(of: "-", with: ""))!
        
//        print(String(b,radix:16).leftPadding(toLength: 2, withPad: "0"))
        
        let res = String(r, radix: 16).leftPadding(toLength: 2, withPad: "0") + String(g, radix: 16).leftPadding(toLength: 2, withPad: "0") + String(b, radix: 16).leftPadding(toLength: 2, withPad: "0")
//        print(String(r,radix: 16))
//        print(r,g,b)
//        print(String(51, radix: 16),String(255, radix: 16),String(61, radix: 16))
//        print("noconvert",red,green,blue)
        print("rgb",r,g,b)
        print(res)
//        return res
//        RGB -0.20103156566619873 1.0005059242248535 -0.2682051658630371 1.0 -68

        return res
    }
}
