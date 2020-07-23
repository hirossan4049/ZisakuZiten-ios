//
//  PlaySelectItemTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/17.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class PlaySelectItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet var plyimageView: UIImageView!

    @IBOutlet weak var BodyView: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        BodyView.layer.cornerRadius = 15
        plyimageView.layer.cornerRadius = 15
//        plyimageView.layer.cornerRadius = 15
        
        // FIXME: TESTTESTEEETTETETE
        plyimageView.backgroundColor = UIColor.randomColor
        
//        BodyView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        

        // 影の方向（width=右方向、height=下方向、CGSize.zero=方向指定なし）
        BodyView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        // 影の色
        BodyView.layer.shadowColor = UIColor.black.cgColor
        // 影の濃さ
        BodyView.layer.shadowOpacity = 0.3
        // 影をぼかし
        BodyView.layer.shadowRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func testpress() {
        print("pressed!")
    }

}
