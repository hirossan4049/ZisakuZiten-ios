//
//  PlayStartViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/25.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class PlayStartViewController: UIViewController {
    
    @IBOutlet weak var groupSelectView: UIView!
    @IBOutlet weak var chevronDownImg: UIImageView!
    let groupPickerViewOwner:GroupPickerViewOwner = GroupPickerViewOwner()

    
    var isGroupPickerDraw:Bool = false{
        didSet{
            if isGroupPickerDraw{
                add_groupPickerView()
            }else{
                remove_groupPickerView()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(groupPickerClicked(sender:)))
        print(tapGesture)
        groupSelectView.addGestureRecognizer(tapGesture)
        groupSelectView.layer.cornerRadius = 17
        groupSelectView.layer.borderColor = UIColor(hex: "EBEBEB").cgColor
        groupSelectView.layer.borderWidth = 1
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func add_groupPickerView(){
        // -------- DROPDOWN IMAGE -------
        let imtiming = UICubicTimingParameters(animationCurve: .linear)
        let imanimator:UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.2, timingParameters: imtiming)
        imanimator.addAnimations {
            self.chevronDownImg.transform = CGAffineTransform(rotationAngle: CGFloat.pi/180*180)
        }
        imanimator.startAnimation()
        
        // ======== DROPDOWN ==========
        // 座標関係
        let x:CGFloat = self.groupSelectView.frame.origin.x
        let y:CGFloat = groupSelectView.frame.origin.y + groupSelectView.frame.size.height
        
        let width:CGFloat = self.groupSelectView.frame.width
        let height:CGFloat = self.view.frame.height - y - 60

        let frame:CGRect = CGRect(x: x, y: y, width: width, height: height)
        //カスタマイズViewを生成
//        let myVeiw:GroupPickerView = GroupPickerView(frame: frame)
//        let myVeiw:GroupPickerViewOwner = GroupPickerViewOwner()
        
        //animation
        let timing = UICubicTimingParameters(animationCurve: .linear)
        // アニメーションの時間を2秒、タイミングパラメータに上で定義したtimingをセット
        groupPickerViewOwner.groupPickerView.frame = CGRect(x: x, y: y, width: width, height: 0)
//        groupPickerViewOwner.groupPickerView.frame = frame
        self.groupPickerViewOwner.groupPickerView.layer.frame.size.height = 0
        self.groupPickerViewOwner.groupPickerView.layoutIfNeeded()
        let animator:UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.2, timingParameters: timing)
        animator.addAnimations {
//            self.groupPickerViewOwner.groupPickerView.center.y += y
            self.groupPickerViewOwner.groupPickerView.frame.size.height += height
//            self.groupPickerViewOwner.groupPickerView.layer.frame.size.height += 100
//            self.groupPickerViewOwner.groupPickerView.layoutIfNeeded()

        }
        animator.startAnimation()

        self.view.addSubview(groupPickerViewOwner.groupPickerView)
//        groupPickerViewOwner.groupPickerView.frame = frame
        groupPickerViewOwner.groupPickerView.layer.cornerRadius = 30
        // =============================
    }
    func remove_groupPickerView(){
        // -------- DROPDOWN IMAGE -------
        let imtiming = UICubicTimingParameters(animationCurve: .linear)
        let imanimator:UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.2, timingParameters: imtiming)
        imanimator.addAnimations {
            self.chevronDownImg.transform = CGAffineTransform(rotationAngle: CGFloat.pi/180)
        }
        imanimator.startAnimation()
//        self.view.willRemoveSubview(groupPickerViewOwner.groupPickerView)
        //animation
        let timing = UICubicTimingParameters(animationCurve: .linear)
        // アニメーションの時間を2秒、タイミングパラメータに上で定義したtimingをセット
        let y:CGFloat = groupSelectView.frame.origin.y + groupSelectView.frame.size.height
        let height:CGFloat = self.view.frame.height - y - 60
        self.groupPickerViewOwner.groupPickerView.layoutIfNeeded()
        let animator:UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.2, timingParameters: timing)
        animator.addAnimations {
            self.groupPickerViewOwner.groupPickerView.frame.size.height -= height
//            self.groupPickerViewOwner.groupPickerView.frame = frame
        }
        animator.addCompletion{_ in
            self.groupPickerViewOwner.groupPickerView.removeFromSuperview()
        }
        animator.startAnimation()
        
        print("REMOVED")
    }
    

    @objc func groupPickerClicked(sender: UITapGestureRecognizer) {
        print("tap")
        isGroupPickerDraw = !isGroupPickerDraw
        print(isGroupPickerDraw)
    }

}
