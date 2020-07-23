//
//  UIColor+rando,.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/23.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var randomColor: UIColor {
        let r = CGFloat.random(in: 0 ... 255) / 255.0
        let g = CGFloat.random(in: 0 ... 255) / 255.0
        let b = CGFloat.random(in: 0 ... 255) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
