//
//  CustomTabBar.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/12.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBar: UITabBar {
    /// indexを受け取り、タブのUIImageViewを返却する
    func barItemImage(index: Int) -> UIImageView? {
        let view = subviews[index + 1]
        return view.recursiveSubviews.compactMap { $0 as? UIImageView }
        .first
    }
}
