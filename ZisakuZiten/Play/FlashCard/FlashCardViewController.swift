//
//  FlashCardViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/28.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class FlashCardViewController: PlayBaseViewController {
    
    @IBOutlet weak var mainLabel:UILabel!
    @IBOutlet weak var backgroundView:UIView!
    
    var zitens:List<Ziten>!
//    var createTime:Date!
    // 偶数 表 奇数 裏
    var counter:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView.layer.cornerRadius = 13
        
        self.mainLabel.textColor = .baseTextColor
        backgroundView.backgroundColor = .lightGray
        //Viewのクリックを
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextWord(sender:)))
        backgroundView.addGestureRecognizer(tapGesture)
        
//        let realm = try! Realm()
//        self.zitens = realm.objects(Group.self).filter("createTime==%@",createTime)[0].ziten_upT_List

        mainLabel.adjustsFontSizeToFitWidth = true
//        mainLabel.text = self.group[0].title
//        setFlashCard()
        // Do any additional setup after loading the view.


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        self.zitens = realm.objects(Group.self).filter("createTime==%@",createTime!)[0].ziten_upT_List
        setFlashCard()
    }
    
    @objc func nextWord(sender: UITapGestureRecognizer){
        UIView.transition(with: backgroundView, duration: 0.3, options: [.transitionFlipFromRight], animations: nil, completion: nil)
        setFlashCard()
    }
    
    func setFlashCard(){
        print(self.counter,self.zitens.count)
        if self.counter >= (self.zitens.count * 2){
            exitDialog()
            return
        }
        if counter % 2 == 0{
            mainLabel.textColor = .black
            mainLabel.text =  self.zitens[counter / 2].title
        }
        else{
            mainLabel.textColor = .red
            mainLabel.text = self.zitens[(self.counter - 1) / 2].content
        }
        self.counter += 1
    }
    
    func exit(){
        self.dismiss(animated: true, completion: nil)
        self.counter = 0
    }
    
    @IBAction func dismissClicked(){
        exit()
    }
    
    func exitDialog(){
        let dialog = UIAlertController(title: "終了", message: "すべての単語が表示し終わりました。もう一度プレイしたい場合はもう一度を押してください。", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "閉じる", style: .default, handler: { action in
            self.exit()
        }))
        dialog.addAction(UIAlertAction(title: "もう一度", style: .default, handler: { action in
            self.counter = 0
            self.setFlashCard()
        }))

        self.present(dialog, animated: true, completion: nil)
    }


}
