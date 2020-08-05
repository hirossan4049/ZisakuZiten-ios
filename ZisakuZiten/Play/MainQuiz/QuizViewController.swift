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

        // ScrollViewどうしよ
        mainLabel.text = "絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる。"
        // Do any additional setup after loading the view.
        btn_settings()
        set()
        

//        let isCorrectPupup:CorrectPopupViewController = self.storyboard?.instantiateViewController(withIdentifier: "CorrectPupupViewController") as! CorrectPopupViewController
//        isCorrectPupup.modalPresentationStyle = .overFullScreen
//        isCorrectPupup.modalTransitionStyle = .crossDissolve
        

//        self.present(isCorrectPupup, animated: false, completion: nil)

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
        let alertView = CorrectPopupViewController()
        alertView.isCorrect = true
        alertView.modalTransitionStyle = .crossDissolve
        alertView.modalPresentationStyle = .overCurrentContext
        present(alertView, animated: false, completion: nil)

//        self.dismiss(animated: true, completion: nil)
    }
    
    // Quiz 4 Buttons click event
    @IBAction func onClick(sender:UIButton){
        print(sender.tag);
        if sender.tag == 0{
            // uncorrect
            print("uncorerct")
        }else{
            //correct
            print("correct!")
            set()
        }
    }



}
