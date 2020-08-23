//
//  CreateGroupViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/17.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    @IBOutlet weak var bodyView:UIView!
    @IBOutlet weak var createBtn:UIButton!
    @IBOutlet weak var cancelBtn:UIButton!
    @IBOutlet weak var categoryBtn:UIButton!
    
    @IBOutlet weak var nameTextField:UITextField!
    
    @IBOutlet weak var categoryView:CategoryView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRadiuser(view: self.bodyView, radius: 13)
        viewRadiuser(view: self.createBtn, radius: 20)
        viewRadiuser(view: self.cancelBtn, radius: 20)
        viewRadiuser(view: self.categoryBtn, radius: 20)
        viewRadiuser(view: self.nameTextField, radius: 10)
//        viewRadiuser(view: self.categoryView, radius: 5)
        self.categoryView.backgroundColor = .none
        nameTextField.attributedPlaceholder = NSAttributedString(string: "どんな辞典の名前にする？", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])


        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func exit(){
        self.dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func viewRadiuser(view:UIView,radius:CGFloat){
        view.layer.cornerRadius = radius
    }
    
    func createPost(title:String,category:Category){
        let postArgs:[String: String] = ["title": title]
        NotificationCenter.default.post(name: .toExitView,object: nil,userInfo: postArgs)
    

    }

}
