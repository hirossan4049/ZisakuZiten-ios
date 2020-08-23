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
    static let backgroundColor = light_dark_changer(light: UIColor(hex:"FFD740"), dark: UIColor(hex:"17122B"))
    static let tabBarColor = light_dark_changer(light: UIColor(hex:"00ACC1"), dark: UIColor(hex:"2D2A36"))
    static let floatingBtnCOlor = light_dark_changer(light: UIColor(hex:"6D4C41"), dark: UIColor(hex:"3E0789"))
    static let navigationBarColor = light_dark_changer(light: UIColor(hex:"BFBFBF"), dark: UIColor(hex:"464646"))
    
    
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
