//
//  UIView+Blur.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/05.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func addBlur(style: UIBlurEffect.Style = .extraLight) {
        let blurView = UIVisualEffectView()
        blurView.effect = UIBlurEffect(style: style)
        blurView.frame = bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .clear
        insertSubview(blurView, at: 0)
    }

//    func removeBlur() {
//        subviews
//            .filter { $0.className == UIVisualEffectView.className }
//            .forEach { $0.removeFromSuperview() }
//    }
}
