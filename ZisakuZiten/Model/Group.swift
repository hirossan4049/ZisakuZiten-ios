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
    
    // zitenのリスト。Androidとサーバーサイドがこう実装しちゃってるから仕方なく。自分が書いたんですけどね。
    /// FIXME;ziten_upT_Listじゃなくてziten_updT_Listでした。キレそう
    dynamic var ziten_upT_List = List<Ziten>()
    @objc dynamic var category: Date? = nil
    
    
    //////////////////////////////////////////////////無理。
//    private enum CodingKeys: String, CodingKey {
//        case title
//        case updateTime
//        case ziten_upT_List = "ziten_updT_List"
////        case age
//    }
//    required convenience public init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        title = try container.decode(String.self, forKey: .title)
//        updateTime = try container.decode(Date.self, forKey: .updateTime)
//        ziten_upT_List = try container.decode(List<Ziten>.self, forKey: .ziten_upT_List)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        let birthdayStr = try container.decode(String.self, forKey: .birthday)
//        birthday = dateFormatter.date(from: birthdayStr)!
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(isFromJapan, forKey: .isFromJapan)
//        try container.encode(favoriteSong, forKey: .favoriteSong)
//        try container.encode(age.value, forKey: .age)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        dateFormatter.timeZone = TimeZone.current
//        let bitrhdayStr = dateFormatter.string(from: birthday)
//        try container.encode(bitrhdayStr, forKey: .birthday)
//
//    }
    
}
