//
//  Object+ toDictionary.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/23.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import RealmSwift

//extension Object {
//    func toDictionary() -> Dictionary<String, AnyObject> {
//        let properties = self.objectSchema.properties.map { $0.name }
//        let dictionary = self.dictionaryWithValues(forKeys: properties)
//
//        let mutabledic = NSMutableDictionary()
//        mutabledic.setValuesForKeys(dictionary)
//
//        for prop in self.objectSchema.properties as [Property]! {
//            if let nestedObject = self[prop.name] as? Object {
//                mutabledic.setValue(nestedObject.toDictionary() as NSDictionary, forKey: prop.name)
//            } else if let nestedListObject = self[prop.name] as? ListBase {
//                var objects = [AnyObject]()
//                for index in 0..<nestedListObject._rlmArray.count {
//                    let object = nestedListObject._rlmArray[index] as AnyObject
//                    objects.append(object.toDictionary() as NSDictionary)
//                }
//                mutabledic.setObject(objects, forKey: prop.name as NSCopying)
//            }
//        }
//
//        return mutabledic as NSDictionary as! Dictionary<String, AnyObject>
//    }
//}

