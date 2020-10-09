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
                                 groupMinCount: 1,image1: "flashcardImage1",image2: "flashcardImage2",image3: "flashcardImage3",viewController: FlashCardViewController(nibName: "FlashCardViewController", bundle: nil))
    let quiz = PlayListItem(title: "Quiz", subtitle: "苦手な単語を中心的にクイズとして出題されます。", comment: "苦手な単語を中心的にクイズとして出題されます。",
                            groupMinCount: 4, image1: "quizImage1",image2: "quizImage2",image3: "quizImage3", viewController: QuizViewController(nibName: "QuizViewController", bundle: nil))
    let play_audio = PlayListItem(title: "音声で再生", subtitle: "単語と意味を読み上げてくれます。", comment: "単語と意味を読み上げてくれます。",
                                  groupMinCount: 1, image1: "audioPlayImage1", image2: "audioPlayImage2", image3:"audioPlayImage3", viewController: AudioPlayViewController(nibName: "AudioPlayViewController", bundle: nil))
    
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
