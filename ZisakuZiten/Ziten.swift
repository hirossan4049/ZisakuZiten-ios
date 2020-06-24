//
//  Ziten.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import RealmSwift

///THINK OUT LOUD: 辞典ではないよね。って思ったけど多分気の所為。なぜ今まで気づかなかったかは謎。
class Ziten:Object{
    @objc dynamic var title:String? = nil
    @objc dynamic var content: String? = nil
    @objc dynamic var createTime: Date? = nil
    @objc dynamic var updateTime: Date? = nil
}
