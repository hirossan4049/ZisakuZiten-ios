//
//  PlayListItem.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/27.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

class PlayListItem: NSObject {
    
    var title:String
    var subtitle:String
    var comment:String
    var groupMinCount:Int
    var image1:String
    var image2:String
    var image3:String
    var viewController:UIViewController
//    var viewController:NSObject
    
    init(title:String,subtitle:String,comment:String,groupMinCount:Int,image1:String,image2:String,image3:String,viewController:UIViewController) {
        self.title = title
        self.subtitle = subtitle
        self.comment = comment
        self.groupMinCount = groupMinCount
        self.viewController = viewController
        
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
    }
}
