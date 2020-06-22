//
//  CreateZitenViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/22.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class CreateZitenViewController: UIViewController {
    
    var group_createTime: Date?
    

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func ok_on_press() {
        if (titleTextField.text == ""){
            print("タイトルがない。")
        }else if (contentTextField.text == ""){
            print("コンテンツがない。")
        }else{
            //FIXME:もしある単語であれば確認Dialog出す。
            print("辞典を登録しています.....")
            let ziten:Ziten = Ziten()
            let now:Date = Date()
            ziten.title = titleTextField.text
            ziten.content = contentTextField.text
            ziten.createTime = now
            ziten.updateTime = now
            let realm = try! Realm()
            var group:Group = realm.objects(Group.self).filter("createTime==%@", group_createTime)[0]
            try! realm.write{
                group.ziten_upT_List.append(ziten)
            }
            print(group)
            print("Done!")
            self.dismiss(animated: true, completion: nil)

        }
    }

    @IBAction func cancel_on_press() {
        self.dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        outputText.text = inputText.text
        print("touchesBegan")
        self.view.endEditing(true)
    }

}
