//
//  PlayStartViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/25.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class PlayStartViewController: UIViewController {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var commentLabel:UILabel!
    
    @IBOutlet weak var groupSelectView: UIView!
    @IBOutlet weak var chevronDownImg: UIImageView!
    @IBOutlet weak var selectLabel:UILabel!
    @IBOutlet weak var startBtn:PlayStartButton!
    @IBOutlet weak var erorrLabel:UILabel!
    
    var playItem:PlayListItem!
    let groupPickerViewOwner:GroupPickerViewOwner = GroupPickerViewOwner()
    
    let NO_SELECTED_TEXT:String = "-- No Selected --"
    var selected_createTime:Date? = nil

    
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
                
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.pickerExitCall(_:)),
                                               name: .toExitView,
                                               object: nil)
        
        self.startBtn.btnStatus(isEnb:false)
        self.selectLabel.text = NO_SELECTED_TEXT
        self.erorrLabel.isHidden = true
        
        // TEST
//        self.playItem = Playlist().flashcard
        
        //
        self.titleLabel.text = self.playItem.title
        self.commentLabel.text = self.playItem.comment
        
        // Do any additional setup after loading the view.
        selected_Group_playruncheck()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selected_Group_playruncheck()

    }
    
    @IBAction func startOnClick(){
        let playVC = FlashCardViewController(nibName: "FlashCardViewController", bundle: nil)
        playVC.createTime = self.selected_createTime
        playVC.modalPresentationStyle = .fullScreen
        self.present(playVC, animated: true, completion: nil)
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
        
        // ======== DROPDOWN SELECT LISTVIEW REMOVE =======
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
//        isGroupPickerDraw = !isGroupPickerDraw
        isGroupPickerDraw.toggle()
        print(isGroupPickerDraw)
    }
    
    @objc func pickerExitCall(_ notification: NSNotification){
        print("Exit called!!")
        let createTime = notification.userInfo!["createTime"]
        self.selected_createTime = createTime! as! Date
        let realm = try! Realm()
        let text = realm.objects(Group.self).filter("createTime==%@", createTime)[0].title
        selectLabel.text = text
        isGroupPickerDraw = false
        selected_Group_playruncheck()
    }
    
    func selected_Group_playruncheck() -> Bool{
        if self.selected_createTime == nil{
            print("NIL")
            return false
        }
        let realm = try! Realm()
        let group = realm.objects(Group.self).filter("createTime==%@", self.selected_createTime!)[0]
        
        if group.ziten_upT_List.count < self.playItem.groupMinCount{
            self.startBtn.btnStatus(isEnb: false)
            errorTextDraw(error: "単語がn個以上必要です")
            return false
        }else{
            self.erorrLabel.isHidden = true
            self.startBtn.btnStatus(isEnb: true)
            return true
        }
    }
    
    func errorTextDraw(error:String){
        print("ERORR:",error)
        self.erorrLabel.isHidden = false
        self.erorrLabel.text = error
    }

}
