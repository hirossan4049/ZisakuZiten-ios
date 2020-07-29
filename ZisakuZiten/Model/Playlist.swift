//
//  Playlist.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/19.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation

class Playlist{
    let flashcard = PlayListItem(title: "FlashCard",subtitle:"単語と意味が交互に表示されます。", comment: "単語と意味が交互に表示されます。",
                                 groupMinCount: 1,viewController: FlashCardViewController(nibName: "FlashCardViewController", bundle: nil))
    let quiz = PlayListItem(title: "quiz", subtitle: "苦手な単語を中心的にクイズとして出題されます。", comment: "苦手な単語を中心的にクイズとして出題されます。",
                                 groupMinCount: 4,viewController: QuizViewController(nibName: "QuizViewController", bundle: nil))
    let play_audio = PlayListItem(title: "音声で再生", subtitle: "単語と意味を読み上げてくれます。", comment: "単語と意味を読み上げてくれます。",
                                  groupMinCount: 1,viewController: ViewController())
    
    func getAllItems() -> [PlayListItem]{
        return [flashcard, quiz, play_audio]
    }
//    
//    init(title:String,detail:String) {
//        self.title = title
//        self.detail = detail
//        
//    }
}
