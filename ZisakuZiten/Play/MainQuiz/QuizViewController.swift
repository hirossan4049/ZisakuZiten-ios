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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        self.zitens = realm.objects(Group.self).filter("createTime==%@",createTime)[0].ziten_upT_List
        btn_settings()
        mainLabel.adjustsFontSizeToFitWidth = true
        // ScrollViewどうしよ
        mainLabel.text = "絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる。"
        // Do any additional setup after loading the view.
        set()
    }
    
    func set(){
        var shuffled = self.zitens.shuffled()
        
        // Python [zitens[x] for x in range(4)]
//        let ans = self.zitens[0]
//        let oth1 = self.zitens[1].content
//        let oth2 = self.zitens[2].content
//        let oth3 = self.zitens[3].content
//        
        var buttons = [btn1,btn2,btn3,btn4]
        buttons.shuffle()
        for item in buttons{
            item?.setTitle(shuffled.first?.title, for: .normal)
            shuffled.removeFirst()
        }
        
        
        
    }
    
    func btn_settings(){
        btn1.layer.cornerRadius = 13
        btn2.layer.cornerRadius = 13
        btn3.layer.cornerRadius = 13
        btn4.layer.cornerRadius = 13

    }
    
    @IBAction func exit(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // Quiz 4 Buttons click event
    @IBAction func onClick(sender:UIButton){
        print(sender.tag);
//        switch sender.tag {
//        case 0:
//
//        default:
//            return
//        }
    }



}
