//
//  ZitenEditerViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/22.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class CreateZitenViewController: UIViewController {

    var group_createTime: Date?
    // Detail mode only
    var ziten_createTime: Date?

    // 0 == Create
    // 1 == Detail
    var mode: Int? = 0
    let realm = try! Realm()
    var group: Group!


    @IBOutlet weak var explainTextField: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.group = realm.objects(Group.self).filter("createTime==%@", group_createTime)[0]
        // TODO:説明とか編集なら単語をTextFieldに入れるだとか。
        if self.mode == 0 {
            // Create mode
            explainTextField.text = "単語を作成"
        } else if self.mode == 1 {
            // Detail mode
            let ziten:Ziten = group.ziten_upT_List.filter("createTime==%@",ziten_createTime)[0]
            explainTextField.text = "単語を編集"
            titleTextField.text = ziten.title
            contentTextField.text = ziten.content
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
    }


    func create_ziten(title: String, content: String) {
        print("辞典を登録しています.....")
        let ziten: Ziten = Ziten()
        let now: Date = Date()
        ziten.title = title
        ziten.content = content
        ziten.createTime = now
        ziten.updateTime = now
        try! realm.write {
            self.group.ziten_upT_List.append(ziten)
        }
        print(group)
        print("Done!")
    }

    func update_ziten(title: String, content: String) {
        ///titleとcontentがもとより異なってるか確認してもいいけど無駄な希ガス
        print("updating.... ziten")
        var ziten:Ziten = group.ziten_upT_List.filter("createTime==%@",ziten_createTime)[0]
        let now:Date = Date()
        try! realm.write{
            ziten.title = title
            ziten.content = content
            ziten.updateTime = now
        }
        print("done")
    }


    @IBAction func ok_on_press() {
        if (titleTextField.text == "") {
            print("タイトルがない。")
        } else if (contentTextField.text == "") {
            print("コンテンツがない。")
        } else {
            //FIXME:もしある単語であれば確認Dialog出す。
            switch self.mode {
            case 0:
                create_ziten(title: titleTextField.text!, content: contentTextField.text!)
            case 1:
                update_ziten(title: titleTextField.text!, content: contentTextField.text!)
            default:
                print("error:mode not found")
            }

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
