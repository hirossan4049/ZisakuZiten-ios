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

    @IBOutlet weak var bodyView: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        bodyView.layer.cornerRadius = 15
        plyimageView.layer.cornerRadius = 15
//        plyimageView.layer.cornerRadius = 15
        
        // FIXME: TESTTESTEEETTETETE
        plyimageView.backgroundColor = UIColor.randomColor
        
//        BodyView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        

        // 影の方向（width=右方向、height=下方向、CGSize.zero=方向指定なし）
        bodyView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        // 影の色
        bodyView.layer.shadowColor = UIColor.black.cgColor
        // 影の濃さ
        bodyView.layer.shadowOpacity = 0.3
        // 影をぼかし
        bodyView.layer.shadowRadius = 6
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func bodyViewClicked(_ sender: Any) {
//        self.BodyView.backgroundColor = .gray

    }
    
    func clickDraw(){
        //animation
        let timing = UICubicTimingParameters(animationCurve: .linear)
        var circle = UIBezierPath(arcCenter: CGPoint(x: 150, y: 150), radius: 100, startAngle: 0, endAngle: CGFloat(Double.pi)*2, clockwise: true)
        // 内側の色
        UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).setFill()
        circle.fill()
//        let animator:UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.2, timingParameters: timing)
//        animator.addAnimations {
//            circle.radi
//        }
//        animator.startAnimation()
    }
    


    @IBAction func testpress() {
        print("pressed!")
    }

}
