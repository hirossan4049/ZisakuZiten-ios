//
//  ZitenEditerViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/22.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class CreateZitenViewController: UIViewController, UITextViewDelegate {

    var group_createTime: Date?
    // Detail mode only
    var ziten_createTime: Date?

    // 0 == Create
    // 1 == Detail
    var mode: Int? = 0
    let realm = try! Realm()
    var group: Group!


    @IBOutlet weak var explainTextField: UILabel!
    @IBOutlet weak var titleTextField: UITextView!
    @IBOutlet weak var contentTextField: UITextView!
    
    @IBOutlet weak var okButton:UIButton!
    @IBOutlet weak var cancelButton:UIButton!
    
    fileprivate let titleLabelHintText = "単語を入力"
    fileprivate let contentLabelHintText = "意味を入力"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        okButton.layer.cornerRadius = 17
        cancelButton.layer.cornerRadius = 17
        cancelButton.backgroundColor = .navigationBarColor
        okButton.backgroundColor = .buttonBaseColor
        self.view.backgroundColor = .backgroundColor
        titleTextField.backgroundColor = .textFieldBackgroundColor
        contentTextField.backgroundColor = .textFieldBackgroundColor
        
        var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(tapGestureTitle(_:)))
        titleTextField.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer = UITapGestureRecognizer( target: self,action: #selector(tapGestureContent(_:)))
        contentTextField.addGestureRecognizer(tapGestureRecognizer)
        
        titleTextField.tag = TextViewType.title.rawValue
        contentTextField.tag = TextViewType.conntent.rawValue
        
        titleTextField.delegate = self
        contentTextField.delegate = self
        
        titleTextField.layer.cornerRadius = 10
        contentTextField.layer.cornerRadius = 10

        
        
        self.group = realm.objects(Group.self).filter("createTime==%@", group_createTime!)[0]
        // TODO:説明とか編集なら単語をTextFieldに入れるだとか。
        if self.mode == 0 {
            // Create mode
            explainTextField.text = "単語を作成"
            okButton.titleLabel!.text = "作成"
        } else if self.mode == 1 {
            // Detail mode
            let ziten:Ziten = group.ziten_upT_List.filter("createTime==%@",ziten_createTime!)[0]
            explainTextField.text = "単語を編集"
            okButton.titleLabel!.text = "更新"
            titleTextField.text = ziten.title
            contentTextField.text = ziten.content
        }
        
        titleTextField.textColor = .baseTextColor
        contentTextField.textColor = .baseTextColor
        
        if titleTextField.text.isEmpty {
            titleTextField.text = titleLabelHintText
            titleTextField.textColor = UIColor.lightGray
        }
        if contentTextField.text.isEmpty{
            contentTextField.text = contentLabelHintText
            contentTextField.textColor = UIColor.lightGray
        }

    }
    
    enum TextViewType:Int {
        case title = 1
        case conntent = 2
    }
    
    
    @objc func tapGestureTitle(_ gestureRecognizer: UITapGestureRecognizer){
        titleTextField.becomeFirstResponder()
        if titleTextField.textColor == UIColor.lightGray{
            titleTextField.text = ""
            titleTextField.textColor = .baseTextColor
        }

    }
    @objc func tapGestureContent(_ gestureRecognizer: UITapGestureRecognizer){
        contentTextField.becomeFirstResponder()
        if contentTextField.textColor == UIColor.lightGray{
            contentTextField.text = ""
            contentTextField.textColor = .baseTextColor
        }
    }
    
    @objc func myTargetFunction(textField: UITextField) {
        print("myTargetFunction")
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) -> Bool {
        print("textFieldDidBeginEditing")
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {
            if textView.tag == TextViewType.title.rawValue{
                textView.text = titleLabelHintText
            }else if textView.tag == TextViewType.conntent.rawValue{
                textView.text = contentLabelHintText

            }
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = .baseTextColor
            textView.text = text
        }
        else {
            return true
        }
        return false
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
    }


    func create_ziten(title: String, content: String) {
        let ziten: Ziten = Ziten()
        let now: Date = Date()
        ziten.title = title
        ziten.content = content
        ziten.createTime = now
        ziten.updateTime = now
        try! realm.write {
            self.group.ziten_upT_List.append(ziten)
        }
        print(group!)
        print("Done!")
    }

    func update_ziten(title: String, content: String) {
        ///titleとcontentがもとより異なってるか確認してもいいけど無駄な希ガス
        print("updating.... ziten")
        let ziten:Ziten = group.ziten_upT_List.filter("createTime==%@",ziten_createTime!)[0]
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
        }
        if (contentTextField.text == "") {
            print("コンテンツがない。")
        }
        if (titleTextField.text == titleLabelHintText){
            print("title not found")
            titleTextField.text = ""
        }
        if (contentTextField.text == contentLabelHintText){
            print("contennt not found")
            contentTextField.text = ""
        }
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

    @IBAction func cancel_on_press() {
        self.dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        outputText.text = inputText.text
        print("touchesBegan")
        self.view.endEditing(true)
        if titleTextField.text.isEmpty {

            titleTextField.text = titleLabelHintText
            titleTextField.textColor = UIColor.lightGray
        }
        if contentTextField.text.isEmpty{
            contentTextField.text = contentLabelHintText
            contentTextField.textColor = .lightGray
        }
    }

}
