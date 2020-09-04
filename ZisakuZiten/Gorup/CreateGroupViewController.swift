//
//  CreateGroupViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/17.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

/// FIXME:UIPresentationController :(((((
class CreateGroupViewController: UIViewController {
    
    @IBOutlet weak var bodyView:UIView!
    @IBOutlet weak var createBtn:UIButton!
    @IBOutlet weak var cancelBtn:UIButton!
    @IBOutlet weak var categoryBtn:UIButton!
    
    @IBOutlet weak var titleLabel:UILabel!
    
    @IBOutlet weak var nameTextField:UITextField!
    
    @IBOutlet weak var categoryView:CategoryView!
    
    // true == edit mode
    var EDIT_MODE:Bool = false
    // edit mode only
    var createTime:Date!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRadiuser(view: self.bodyView, radius: 13)
        viewRadiuser(view: self.createBtn, radius: 20)
        viewRadiuser(view: self.cancelBtn, radius: 20)
        viewRadiuser(view: self.categoryBtn, radius: 20)
        viewRadiuser(view: self.nameTextField, radius: 10)
//        viewRadiuser(view: self.categoryView, radius: 5)
        self.categoryView.backgroundColor = .none
        self.bodyView.backgroundColor = .baseColor
        self.titleLabel.textColor = .baseTextColor
        self.createBtn.backgroundColor = .buttonBaseColor
        self.nameTextField.backgroundColor = .createGrouptextFieldColor
        self.categoryBtn.backgroundColor = .buttonSubColor
//        nameTextField.attributedPlaceholder = NSAttributedString(string: "どんな辞典の名前にする？", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        if EDIT_MODE{
            print("EDIT MODE SET TITLE LABEL")
            let realm = try! Realm()
            let group = realm.objects(Group.self).filter("createTime==%@", createTime)[0]
            self.nameTextField.text = group.title
            self.titleLabel.text = "辞典の名前を編集"
        }


        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        outputText.text = inputText.text
        print("touchesBegan")
        self.view.endEditing(true)
    }
    
    @IBAction func exit(){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func categorySettingOnPrs(){
        let viewController = SelectCategoryViewController()
        viewController.modalPresentationStyle = .pageSheet
        self.present(viewController, animated: true, completion: nil)
    }
    @IBAction func createOnPrs(){
        if EDIT_MODE{
            update(title: nameTextField.text!,createTime: createTime)
        }else{
            create(title: nameTextField.text!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewRadiuser(view:UIView,radius:CGFloat){
        view.layer.cornerRadius = radius
    }
    
    func createPost(title:String,category:Category){
        let postArgs:[String: String] = ["title": title]
        NotificationCenter.default.post(name: .toExitView,object: nil,userInfo: postArgs)
    }
    
    
//    func create(title:String,category:Category){
    func create(title:String){
        let instanceGroup: Group = Group()
        let now = Date()
        instanceGroup.title = title
        instanceGroup.createTime = now
        instanceGroup.updateTime = now
//        instanceGroup.category
        let insRealm = try! Realm()
        try! insRealm.write {
            insRealm.add(instanceGroup)
        }
    }
    func update(title:String,createTime:Date){
        let realm = try! Realm()
        let group = realm.objects(Group.self).filter("createTime==%@", createTime)[0]
        let now:Date = Date()
        try! realm.write{
            group.title = title
            group.updateTime = now
        }
        print("done")
        
    }

}
