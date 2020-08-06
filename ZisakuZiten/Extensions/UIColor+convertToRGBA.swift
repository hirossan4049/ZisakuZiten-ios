//
//  UIColor+convertToRGB.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/06.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    func convertToRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
        let components = self.cgColor.components! // UIColorをCGColorに変換し、RGBとAlphaがそれぞれCGFloatで配列として取得できる
        return (red: components[0], green: components[1], blue: components[2], alpha: components[3])
    }
}
