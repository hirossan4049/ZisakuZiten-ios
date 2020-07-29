//
//  PlayListItem.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/27.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

// Playlistとかぶってるのまずい。
class PlayListItem: NSObject {
    
    var title:String
    var subtitle:String
    var comment:String
    var groupMinCount:Int
    var viewController:UIViewController
//    var viewController:NSObject
    
    init(title:String,subtitle:String,comment:String,groupMinCount:Int,viewController:UIViewController) {
        self.title = title
        self.subtitle = subtitle
        self.comment = comment
        self.groupMinCount = groupMinCount
        self.viewController = viewController
    }
}
