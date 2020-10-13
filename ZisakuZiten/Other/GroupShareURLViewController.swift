//
//  GroupShareURLViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/07.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import AudioToolbox


class GroupShareURLViewController: UIViewController {
    var delegate: ViewController?

    @IBOutlet weak var bodyView:UIView!
    @IBOutlet weak var toastView:UIView!
    @IBOutlet weak var toastLabel:UILabel!
    @IBOutlet weak var qrImageView:UIImageView!
    @IBOutlet weak var shareBtn:UIButton!
    var url:String!
    var id:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bodyView.layer.cornerRadius = 13
        self.bodyView.backgroundColor = .backgroundColor
        
        toastView.layer.cornerRadius = 5
        toastView.backgroundColor = .backgroundColor
        toastLabel.textColor = .baseTextColor
        toastView.isHidden = true
        shareBtn.layer.cornerRadius = 10
        shareBtn.layer.shadowColor = UIColor.black.cgColor
        self.view.backgroundColor = .none

    }
    
    @IBAction func share(sender: UIButton) {
      let shareText = "シェアコードが届いています。"
      let shareWebsite = NSURL(string: url)!
//      let shareImage = UIImage(named: "shareSample.png")!
//        let activityItems = [shareText, shareWebsite, shareImage] as [Any]
        let activityItems = [shareText, shareWebsite] as [Any]
//        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: [LINEActivity(message: shareText, shareUrl: shareWebsite), ])
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil )
        self.present(activityVC, animated: true, completion: nil)
    }
    

    
    @IBAction func exit(){
        delegate?.dismissDialog()
    }




}
