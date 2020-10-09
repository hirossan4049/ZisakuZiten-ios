//
//  GroupPickerViewOwner.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/26.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

class GroupPickerViewOwner: NSObject {

    var groupPickerView: UIView!
    

    override init() {
        super.init()
        groupPickerView = UINib(nibName: "GroupPickerView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView
        
    }

}
