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
class CreateGroupViewController: UIViewController, UITextFieldDelegate {
    var delegate: ViewController?
    
    @IBOutlet weak var bodyView:UIView!
    @IBOutlet weak var createBtn:UIButton!
    @IBOutlet weak var cancelBtn:UIButton!
    @IBOutlet weak var categoryBtn:UIButton!
    
    @IBOutlet weak var titleLabel:UILabel!
    
    @IBOutlet weak var nameTextField:UITextField!
    
    @IBOutlet weak var categoryView:CategoryView!
    
    var keyboardHideBodyViewRect:CGRect!
    var keyboardShowBodyViewRect:CGRect!
    
    // true == edit mode
    var EDIT_MODE:Bool = false
    // edit mode only
    var createTime:Date!
    
    var group_category:Category!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardHideBodyViewRect = self.bodyView.frame
        
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
        self.cancelBtn.backgroundColor = .navigationBarColor
        self.nameTextField.backgroundColor = .textFieldBackgroundColor
        self.nameTextField.textColor = .baseTextColor
        self.categoryBtn.backgroundColor = .buttonSubColor
//        nameTextField.attributedPlaceholder = NSAttributedString(string: "どんな辞典の名前にする？", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        
        self.bodyView.translatesAutoresizingMaskIntoConstraints = true
        
        self.bodyView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0).isActive = true
        self.bodyView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:0).isActive = true
        
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(self.categorySelected(_:)),
                                                name: SelectCategoryViewController.selectedNotification,
                                                object: nil)
        
        nameTextField.delegate = self
        NotificationCenter.default.addObserver(
          self,
          selector:#selector(keyboardWillShow(_:)),
          name: UIResponder.keyboardWillShowNotification,
          object: nil
        )
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(keyboardWillHide(_:)),
          name: UIResponder.keyboardWillHideNotification,
          object: nil
        )
        
         
        popupanimate()
        self.nameTextField.becomeFirstResponder()

        
        if EDIT_MODE{
            print("EDIT MODE SET TITLE LABEL")
            let realm = try! Realm()
            let group = realm.objects(Group.self).filter("createTime==%@", createTime)[0]
            self.nameTextField.text = group.title
            self.titleLabel.text = "辞典の名前を編集"
            if group.category != nil{
                let category = realm.objects(Category.self).filter("createTime==%@", group.category)[0]
                self.group_category = category
                self.categoryView.isHidden = false
                self.categoryView.mainLabel.text = category.title
                self.categoryView.categoryColorView.tintColor = UIColor(hex:category.colorCode ?? "ffffff")
            }
            
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
    
    func popupanimate(){
        print("POPUPANIMATE")
//        UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseOut,animations: {
//            self.bodyView.transform = CGAffineTransform(scaleX: 245, y: 318)
//
//            },completion: nil)
//        UIView.animate(withDuration: 1, delay: 1, options: .curveLinear, animations: {
//
//            self.bodyView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//        }, completion: { _ in
//             self.bodyView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        })
          
    }
    
    @IBAction func exit(){
        print("dismiss")
        self.dismiss(animated: true, completion: nil)
        delegate?.dismissDialog()
    }
    @IBAction func categorySettingOnPrs(){
        let viewController = SelectCategoryViewController()
        viewController.modalPresentationStyle = .pageSheet
        //TODO:observer
        self.present(viewController, animated: true, completion: nil)
    }
    @IBAction func createOnPrs(){
        if EDIT_MODE{
            update(title: nameTextField.text!,createTime: createTime)
        }else{
            create(title: nameTextField.text!)
        }
//        dismiss(animated: true, completion: nil)
        delegate?.dismissDialog()
    }
    
    
    
    func viewRadiuser(view:UIView,radius:CGFloat){
        view.layer.cornerRadius = radius
    }
    
    @objc func categorySelected(_ notification: NSNotification){
        print("Exit called!!")
        let createTime = notification.userInfo!["createTime"] as! Date
        let realm = try! Realm()
        let category = realm.objects(Category.self).filter("createTime==%@", createTime)[0]
        self.group_category = category
        self.categoryView.isHidden = false
        self.categoryView.mainLabel.text = category.title
        self.categoryView.categoryColorView.tintColor = UIColor(hex:category.colorCode ?? "ffffff")

    }
    
//    func createPost(title:String,category:Category){
//        let postArgs:[String: String] = ["title": title]
//        NotificationCenter.default.post(name: .toExitView,object: nil,userInfo: postArgs)
//    }
    
    
//    func create(title:String,category:Category){
    func create(title:String){
        let instanceGroup: Group = Group()
        let now = Date()
        let insRealm = try! Realm()
        instanceGroup.title = title
        instanceGroup.createTime = now
        instanceGroup.updateTime = now
        if group_category != nil{
            instanceGroup.category = group_category.createTime
        }
//        instanceGroup.category
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
            if group_category != nil{
                group.category = group_category.createTime
            }
        }
        print("done")
        
    }
    
    
    /// MARK : keyboard
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {
          return
        }
        guard (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) != nil else {
          return
        }
        guard ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil else {
          return
        }
        let oframe = self.keyboardHideBodyViewRect!
        let nx = oframe.origin.y - 80
        self.keyboardShowBodyViewRect = CGRect(x: oframe.origin.x, y: nx, width: oframe.width, height: oframe.height)
//        UIView.animate(withDuration: duration , delay: 0.1, animations: {
//            self.bodyView.frame = self.keyboardShowBodyViewRect
//        })
        self.bodyView.frame = self.keyboardShowBodyViewRect
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
//        UIView.animate(withDuration: 1.0 , delay: 0.1, animations: {
//            self.bodyView.frame = self.keyboardHideBodyViewRect
//        })
//        self.bodyView.frame = self.keyboardShowBodyViewRect

        self.bodyView.frame = self.keyboardHideBodyViewRect
    }

}
