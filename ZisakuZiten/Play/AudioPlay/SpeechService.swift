//
//  SpeechService.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/15.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechService {

    let synthesizer = AVSpeechSynthesizer()
     // 再生速度を設定
    var rate: Float = AVSpeechUtteranceDefaultSpeechRate
    // 言語を英語に設定
//    var voice = AVSpeechSynthesisVoice(language: "en-US")
    var voice = AVSpeechSynthesisVoice(language: "ja-JP")

    func say(_ phrase: String) {
        // 話す内容をセット
        let utterance = AVSpeechUtterance(string: phrase)
        utterance.rate = rate
        utterance.voice = voice

        synthesizer.speak(utterance)
    }

    func getVoices() {

        AVSpeechSynthesisVoice.speechVoices().forEach({ print($0.language) })
    }
    
    func stop(){
        synthesizer.stopSpeaking(at: .immediate)
    }
}
