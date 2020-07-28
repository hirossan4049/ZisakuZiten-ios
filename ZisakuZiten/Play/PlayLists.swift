//
//  PlayList.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/27.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation

class PlayLists{
    let flashcard = PlayListItem(title: "title",subtitle:"aa", comment: "Comment",groupMinCount: 1)
    
    func getAllItems() -> [PlayListItem]{
        return [flashcard]
    }
}
