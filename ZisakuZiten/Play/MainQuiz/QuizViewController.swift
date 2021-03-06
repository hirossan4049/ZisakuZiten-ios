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
    var finished_list:[Ziten]! = []
    var finished_isCorrectList:[Bool] = []
    var counter:Int = 0
    var correct_counter:Int = 0
    //FIXME!!!!!!!!!!!!!!!!!!!!
    let NUMBER_OF_QUIZ:Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.adjustsFontSizeToFitWidth = true
        self.buttons = [btn1,btn2,btn3,btn4]
        
        self.view.backgroundColor = .backgroundColor
        self.mainLabelBackView.backgroundColor = .textFieldBackgroundColor
        self.correctRateLabel.textColor = .baseTextColor
        
        mainLabelBackView.layer.cornerRadius = 13
        mainLabelBackView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        mainLabelBackView.layer.shadowColor = UIColor.black.cgColor
        mainLabelBackView.layer.shadowOpacity = 0.2
        mainLabelBackView.layer.shadowRadius = 10
        
        exitButton.imageView?.contentMode = .scaleAspectFit
        exitButton.contentHorizontalAlignment = .fill
        exitButton.contentVerticalAlignment = .fill

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
        let zitens = realm.objects(Group.self).filter("createTime==%@",createTime!)[0].ziten_upT_List
        self.zitens = zitens.shuffled()
    }
    
    func set(){
        if self.counter == NUMBER_OF_QUIZ{
            let playVC = QuizGradeViewController()
            playVC.finished_isCorrectList = self.finished_isCorrectList
            playVC.finished_list = self.finished_list
    //        let playVC = FlashCardViewController(nibName: "FlashCardViewController", bundle: nil)
            playVC.modalPresentationStyle = .fullScreen
            self.present(playVC, animated: true, completion: nil)
        }
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
        if self.zitens.count < 4{
            random_quiz()
            return
            
        }
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
//            print("ZITEN COUNT",self.zitens.count,self.zitens.first?.title)
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
        print(ztns[0].title)
        while true{
            log.debug("ziten tempziten same... repart")
            if ztns[0].createTime == self.tmp_ziten.createTime{
                log.debug("ziten temp ziten same repear...")
                ztns = random_zitenList()
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
    
    // 適当に返すだけ
    func random_ziten() -> Ziten{
        let realm = try! Realm()
        let l_zitens = realm.objects(Group.self).filter("createTime==%@",createTime!)[0].ziten_upT_List
        let random_int = Int.random(in: 0 ... l_zitens.count)
        return l_zitens[random_int]
    }
    func random_zitenList() -> [Ziten]{
        let realm = try! Realm()
        let l_zitens = realm.objects(Group.self).filter("createTime==%@",createTime!)[0].ziten_upT_List
        return l_zitens.shuffled()
    }

    
    func excellent_quiz(){
        log.debug(incorrect_list?.isEmpty)
        let answr = self.incorrect_list.first
        var randomlist = random_zitenList().shuffled()
        var shuffled_list = [answr]
        //ランダムリストと答えが重ならないように。
        var listindx = 1
        for _ in randomlist{
            if listindx == 4{
                print("BREAK")
                break
            }
            let randomitem = randomlist.popLast()
            if answr!.updateTime != randomitem!.updateTime{
                shuffled_list.append(randomitem)
                listindx += 1
            }
            
        }
//        ,randomlist[0],randomlist[1],randomlist[2]]

        var shuffled_buttons:[UIButton] = self.buttons
        // tag all reset
        for item in shuffled_buttons{ item.tag = 0 }
        shuffled_buttons.shuffle()

        mainLabel.text = shuffled_list[0]!.title
        self.tmp_ziten = shuffled_list[0]!
        shuffled_buttons[0].tag = 1
        for item in shuffled_buttons{
            item.setTitle(shuffled_list[0]!.content, for: .normal)
            shuffled_list.remove(at: 0)
        }

        self.incorrect_list.remove(at:0)
        //log.debug("incorrect_list",self.incorrect_list)
    }
    
    func btn_settings(){
        for item in self.buttons{item.layer.cornerRadius = 13}
    }
    func btns_enable(bool:Bool){
        for item in self.buttons{item.isEnabled = bool}
    }
    
    @IBAction func exit(){
        let alert: UIAlertController = UIAlertController(title: "本当に終了してもいいですか？", message: "Quizの途中です。学習結果が保存されません。よろしいですか？", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            self.dismiss(animated: true, completion: nil)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    //ダイアログもなにも出さずにただdismissするだけ。
    func display_discard(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // Quiz 4 Buttons click event
    @IBAction func onClick(sender:UIButton){
        print(sender.tag);
        if sender.tag == 0{
            // uncorrect
            print("incorerct")
            self.incorrect_list.append(self.tmp_ziten)
            self.finished_list.append(self.tmp_ziten)
            self.finished_isCorrectList.append(false)
            correctDraw(isCorrect: false)
        }else{
            //correct
            print("correct!")
            self.correct_counter += 1
            self.correct_list.append(self.tmp_ziten)
            self.finished_list.append(self.tmp_ziten)
            self.finished_isCorrectList.append(true)
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

