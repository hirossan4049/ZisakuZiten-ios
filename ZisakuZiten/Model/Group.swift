//
//  Group.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import RealmSwift

class Group:Object{
    @objc dynamic var title: String? = nil
    @objc dynamic var createTime: Date? = nil
    @objc dynamic var updateTime: Date? = nil
    
    dynamic var ziten_upT_List = List<Ziten>()
    @objc dynamic var category: Date? = nil
    
    
}
