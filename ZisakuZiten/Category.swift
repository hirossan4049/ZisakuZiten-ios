//
//  Category.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
    @objc dynamic var title: String? = nil
    //UIColorじゃ動かんかったからとりあえずString....
    @objc dynamic var colorCode: String? = nil
    @objc dynamic var createTime: Date? = nil
}
