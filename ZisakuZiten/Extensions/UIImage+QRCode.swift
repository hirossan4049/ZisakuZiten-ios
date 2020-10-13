//
//  UIImage+QRCode.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/11.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func makeQRCode(text: String) -> UIImage? {
//        guard let data = text.data(using: .utf8) else { return nil }
//        guard let QR = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data]) else { return nil }
//        let transform = CGAffineTransform(scaleX: 10, y: 10)
//        guard let ciImage = QR.outputImage?.transformed(by: transform) else { return nil }
//        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else { return nil }
//        return UIImage(cgImage: cgImage)
        
        let data = text.data(using: .utf8)

        // Generate the code image with CIFilter
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")

        // Scale it up (because it is generated as a tiny image)
        let scale = UIScreen.main.scale
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }

        // Change the color using CIFilter
        let colorParameters = [
            "inputColor0": CIColor(color: UIColor.baseTextColor), // Foreground
            "inputColor1": CIColor(color: UIColor.clear) // Background
        ]
        let colored = output.applyingFilter("CIFalseColor", parameters: colorParameters)

        return UIImage(ciImage: colored)
    }
}
