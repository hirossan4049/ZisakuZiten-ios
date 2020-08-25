//
//  UIColor+.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/23.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    // 頻繁に使うやつ
    static let backgroundColor = light_dark_changer(light: UIColor(hex:"FFD740"), dark: UIColor(hex:"17122B"))
    static let baseColor = light_dark_changer(light: UIColor(hex: "FFD740"), dark: UIColor(hex: "382C6A"))
    static let tabBarColor = light_dark_changer(light: UIColor(hex:"00ACC1"), dark: UIColor(hex:"2D2A36"))
    static let floatingBtnColor = light_dark_changer(light: UIColor(hex:"6D4C41"), dark: UIColor(hex:"3E0789"))
    static let navigationBarColor = light_dark_changer(light: UIColor(hex:"BFBFBF"), dark: UIColor(hex:"464646"))
    static let baseTextColor = light_dark_changer(light: UIColor(hex:"151515"), dark: UIColor(hex:"C1C1C1"))
    static let buttonBaseColor = light_dark_changer(light: UIColor(hex: "00ACC1"), dark: UIColor(hex: "9E03FF"))
    static let buttonSubColor = light_dark_changer(light: UIColor(hex:"6D4C41"), dark: UIColor(hex:"4400B1"))

    
    // そんなに使わんやつ
    static let groupCellColor = light_dark_changer(light: UIColor(hex:"BFBFBF"), dark: UIColor(hex:"4D4D4D"))
    static let createGrouptextFieldColor = light_dark_changer(light: UIColor(hex:"C7A00C"), dark: UIColor(hex:"6C53D5"))


    
    
    static func light_dark_changer(light:UIColor,dark:UIColor) -> UIColor{
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                return traits.userInterfaceStyle == .dark ?
                    dark:
                    light
                }
        }else{
            return light
        }
    }
}
