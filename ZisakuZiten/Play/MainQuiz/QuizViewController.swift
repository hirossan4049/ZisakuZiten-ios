//
//  QuizViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/29.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class QuizViewController: PlayBaseViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainLabelBackView:UIView!
    
    var zitens:List<Ziten>!
    var buttons:[UIButton]!
    var tmp_ziten:Ziten!
    var correct_list:[Ziten]!
    var incorrect_list:[Ziten]!
    var counter:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        self.zitens = realm.objects(Group.self).filter("createTime==%@",createTime)[0].ziten_upT_List
        mainLabel.adjustsFontSizeToFitWidth = true
        self.buttons = [btn1,btn2,btn3,btn4]
        
        mainLabelBackView.layer.cornerRadius = 13
        mainLabelBackView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        mainLabelBackView.layer.shadowColor = UIColor.black.cgColor
        mainLabelBackView.layer.shadowOpacity = 0.2
        mainLabelBackView.layer.shadowRadius = 10

        // ScrollViewどうしよ

        // Do any additional setup after loading the view.
        btn_settings()
        set()
        

//        let isCorrectPupup:CorrectPopupViewController = self.storyboard?.instantiateViewController(withIdentifier: "CorrectPupupViewController") as! CorrectPopupViewController
//        isCorrectPupup.modalPresentationStyle = .overFullScreen
//        isCorrectPupup.modalTransitionStyle = .crossDissolve
        

//        self.present(isCorrectPupup, animated: false, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        self.zitens = realm.objects(Group.self).filter("createTime==%@",createTime)[0].ziten_upT_List
        reset()
        set()
    }
    
    func reset(){
        self.counter = 0
    }
    
    func set(){
        if self.counter <= self.zitens.count{
            normal_quiz()
        }else if self.counter % 3 == 0{
            normal_quiz()
        }else{
            excellent_quiz()
        }
        self.counter += 1
        
    }
    
    func normal_quiz(){
        var shuffled = self.zitens.shuffled()
        
//        var buttons = [btn1,btn2,btn3,btn4]
        var shuffled_buttons:[UIButton] = self.buttons
        // tag all 0
        for item in shuffled_buttons{ item.tag = 0 }
        shuffled_buttons.shuffle()
        mainLabel.text = shuffled.first?.title
        self.tmp_ziten = shuffled.first
        shuffled_buttons[0].tag = 1
        for item in shuffled_buttons{
            item.setTitle(shuffled.first?.content, for: .normal)
            shuffled.removeFirst()
        }
    }

    
    func excellent_quiz(){
        print(incorrect_list?.isEmpty)
        
    }
    
    func btn_settings(){
        for item in self.buttons{item.layer.cornerRadius = 13}
    }
    func btns_enable(bool:Bool){
        for item in self.buttons{item.isEnabled = bool}
    }
    
    @IBAction func exit(){

        self.dismiss(animated: true, completion: nil)
    }
    
    // Quiz 4 Buttons click event
    @IBAction func onClick(sender:UIButton){
        print(sender.tag);
        if sender.tag == 0{
            // uncorrect
            print("uncorerct")
            correctDraw(isCorrect: false)
        }else{
            //correct
            print("correct!")
            correctDraw(isCorrect: true)
        }
    }
    
    func correctDraw(isCorrect:Bool){
        let alertView = CorrectPopupViewController()
        alertView.isCorrect = isCorrect
        alertView.modalTransitionStyle = .crossDissolve
        alertView.modalPresentationStyle = .overCurrentContext
        present(alertView, animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alertView.dismiss(animated: false, completion: nil)
            self.set()
        }
    }



}
