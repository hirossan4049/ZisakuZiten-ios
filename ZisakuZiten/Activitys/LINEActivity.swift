//
//  LINEActivity.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/11.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit

class LINEActivity: UIActivity {
    let urlScheme: String = "line://msg/text"
    //シェアしたいメッセージ
    var message = "LINEにシェアするよ"
    var shareUrl = NSURL(string: "https://www.apple.com/jp/")!

    init(message: String,shareUrl: NSURL) {
        self.message = message
        self.shareUrl = shareUrl
    }

    override class var activityCategory: UIActivity.Category {
        //actionだと下の段, shareだと上の段に表示される
        return .action
    }

    override var activityTitle: String? {
        //表示の際のテキスト
        return "LINEでシェア"
    }

    override var activityImage: UIImage? {
        //UIActivityに表示されるアイコン
        return UIImage(named: "LINEActivityIcon")
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }

    override func perform() {
        //urlSheme + / + message (+ image or url) のフォーマット
        let urlstring = "\(urlScheme)/\(message)\n\(shareUrl)"
        //日本語などをエンコード
        let encodedURL = urlstring.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL(string: encodedURL!)
        guard let openUrl = url else { return }
        UIApplication.shared.open(openUrl, options: .init(), completionHandler: nil)
        activityDidFinish(true)
    }
}
