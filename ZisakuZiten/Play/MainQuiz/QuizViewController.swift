//
//  QuizViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/29.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift
import Log

class QuizViewController: PlayBaseViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainLabelBackView:UIView!
    @IBOutlet weak var exitButton:UIButton!
    @IBOutlet weak var correctRateLabel:UILabel!
    
    let log = Logger()
    
    var zitens:[Ziten]!
//    var shuffled_zitens:List<Ziten>!
    var buttons:[UIButton]!
    var tmp_ziten:Ziten!
    var correct_list:[Ziten]! = []
    var incorrect_list:[Ziten]! = []
    var counter:Int = 0
    var correct_counter:Int = 0
    let NUMBER_OF_QUIZ:Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.adjustsFontSizeToFitWidth = true
        self.buttons = [btn1,btn2,btn3,btn4]
        
        mainLabelBackView.layer.cornerRadius = 13
        mainLabelBackView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        mainLabelBackView.layer.shadowColor = UIColor.black.cgColor
        mainLabelBackView.layer.shadowOpacity = 0.2
        mainLabelBackView.layer.shadowRadius = 10
        
        exitButton.imageView?.contentMode = .scaleAspectFit
        exitButton.contentHorizontalAlignment = .fill
        exitButton.contentVerticalAlignment = .fill

        // ScrollViewどうしよ

        // Do any additional setup after loading the view.
        reset()
        btn_settings()
        set()
        

//        let isCorrectPupup:CorrectPopupViewController = self.storyboard?.instantiateViewController(withIdentifier: "CorrectPupupViewController") as! CorrectPopupViewController
//        isCorrectPupup.modalPresentationStyle = .overFullScreen
//        isCorrectPupup.modalTransitionStyle = .crossDissolve
        

//        self.present(isCorrectPupup, animated: false, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
        set()
    }
    
    func reset(){
        self.counter = 0
        let realm = try! Realm()
        let zitens = realm.objects(Group.self).filter("createTime==%@",createTime)[0].ziten_upT_List
        self.zitens = zitens.shuffled()
    }
    
    func set(){
        if self.counter <= self.zitens.count{
            log.debug("quiz : NOMAL")
            normal_quiz()
        }else if self.counter % 3 == 0{
            log.debug("quiz : NOMAL mod 3")
            if self.zitens.isEmpty{
                random_quiz()
            }else{
                log.debug("quiz : NOMAL (mod3,but zitens is empty)")
                normal_quiz()
            }
        }else{
            if self.incorrect_list.isEmpty{
                log.debug("quiz : NOMAL (incorrect_list is empty)")
                random_quiz()
            }else{
                log.debug("quiz : excellent quiz.")
                excellent_quiz()
            }
        }
        self.counter += 1
        
    }
    
    func normal_quiz(){
//        var shuffled:List<Ziten> = self.zitens.shuffled()
        
//        var buttons = [btn1,btn2,btn3,btn4]
        var shuffled_buttons:[UIButton] = self.buttons
        // tag all 0
        for item in shuffled_buttons{ item.tag = 0 }
        shuffled_buttons.shuffle()
        mainLabel.text = self.zitens.first?.title
        self.tmp_ziten = self.zitens.first
        shuffled_buttons[0].tag = 1
        for item in shuffled_buttons{
            print("ZITEN COUNT",self.zitens.count,self.zitens.first?.title)
            if self.zitens.count == 0{
                item.setTitle(random_ziten().content, for: .normal)
            }
            else{
                item.setTitle(self.zitens.first?.content, for: .normal)
                self.zitens.removeFirst()
            }
        }
//        self.zitens = shuffled
    }
    
    func random_quiz(){
        log.debug("THIS IS RAMDOM QUIZ")
        var shuffled_buttons:[UIButton] = self.buttons
        // tag all reset
        for item in shuffled_buttons{ item.tag = 0 }
        shuffled_buttons.shuffle()
        
        var ztns = random_zitenList()
        while true{
            log.debug("ziten tempziten same... repart")
            ztns = random_zitenList()
            if ztns[0] == self.tmp_ziten{
            }else{
                break
            }
        }
            
        mainLabel.text = ztns[0].title
        self.tmp_ziten = ztns[0]
        shuffled_buttons[0].tag = 1
        for item in shuffled_buttons{
            item.setTitle(ztns[0].content, for: .normal)
            ztns.remove(at: 0)
            
        }
    }
    
    // 適当に返すだけ。
    func random_ziten() -> Ziten{
        // FIXME: 毎回取得するのなんかやだ。
        let realm = try! Realm()
        let l_zitens = realm.objects(Group.self).filter("createTime==%@",createTime)[0].ziten_upT_List
        //ランダムな数字にして取ったほうが早そう。
        let random_int = Int.random(in: 0 ... l_zitens.count)
        return l_zitens[random_int]
    }
    func random_zitenList() -> [Ziten]{
        let realm = try! Realm()
        let l_zitens = realm.objects(Group.self).filter("createTime==%@",createTime)[0].ziten_upT_List
        return l_zitens.shuffled()
    }

    
    func excellent_quiz(){
        log.debug(incorrect_list?.isEmpty)
        
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
            self.correct_counter += 1
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
            self.setCorrectCounter()
            self.set()
        }
    }
    
    func setCorrectCounter(){
        correctRateLabel.text = "\(self.counter)問中\(self.correct_counter)正解"
    }



}

