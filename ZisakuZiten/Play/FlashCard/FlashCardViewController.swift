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
    
    var group:List<Ziten>!
//    var createTime:Date!
    // 偶数 表 奇数 裏
    var counter:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView.layer.cornerRadius = 13
        
        //Viewのクリックを
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextWord(sender:)))
        backgroundView.addGestureRecognizer(tapGesture)
        
        let realm = try! Realm()
        self.group = realm.objects(Group.self).filter("createTime==%@",createTime)[0].ziten_upT_List

        mainLabel.adjustsFontSizeToFitWidth = true
//        mainLabel.text = self.group[0].title
        setFlashCard()
        // Do any additional setup after loading the view.


    }
    
    @objc func nextWord(sender: UITapGestureRecognizer){
        UIView.transition(with: backgroundView, duration: 0.3, options: [.transitionFlipFromRight], animations: nil, completion: nil)
        setFlashCard()
    }
    
    func setFlashCard(){
        print(self.counter,self.group.count)
        if self.counter >= (self.group.count * 2){
            mainLabel.text =  "END"
            return
        }
        if counter % 2 == 0{
            mainLabel.textColor = .black
            mainLabel.text =  self.group[counter / 2].title
        }
        else{
            mainLabel.textColor = .red
            mainLabel.text = self.group[(self.counter - 1) / 2].content
        }
        self.counter += 1
    }
    
    @IBAction func dismissClicked(){
        self.dismiss(animated: true, completion: nil)
        
//        UIView.transition(with: backgroundView, duration: 0.3, options: [.transitionFlipFromRight], animations: nil, completion: nil)
//        mainLabel.text = "ura"
        

    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
