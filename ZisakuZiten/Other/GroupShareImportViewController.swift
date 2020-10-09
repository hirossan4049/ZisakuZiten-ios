//
//  GroupShareImportViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/07.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class GroupShareImportViewController: UIViewController, UITextFieldDelegate {
    var delegate: ViewController?

    @IBOutlet weak var bodyView:UIView!
    @IBOutlet weak var codeTextField:UITextField!
    
    var keyboardHideBodyViewRect:CGRect!
    var keyboardShowBodyViewRect:CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.keyboardHideBodyViewRect = self.bodyView.frame
        
        self.bodyView.backgroundColor = .backgroundColor
        self.codeTextField.backgroundColor = .textFieldBackgroundColor
        
        self.bodyView.translatesAutoresizingMaskIntoConstraints = true
        
        self.bodyView.center = self.view.center
        self.bodyView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0).isActive = true
        self.bodyView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:0).isActive = true

        bodyView.layer.cornerRadius = 13
        self.view.backgroundColor = UIColor(hex:"000000",alpha: 0.3)
        self.modalPresentationStyle = .overFullScreen
        codeTextField.delegate = self
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
        


        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.codeTextField.becomeFirstResponder()
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        codeTextField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        self.bodyView.frame = self.keyboardShowBodyViewRect
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {
          return
        }
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
          return
        }
        guard let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
          return
        }
        let oframe = self.keyboardHideBodyViewRect!
        let nx = oframe.origin.y - 50
        self.keyboardShowBodyViewRect = CGRect(x: oframe.origin.x, y: nx, width: oframe.width, height: oframe.height)
        print("nannde??ww")
//        UIView.animate(withDuration: duration , delay: 0.1, animations: {
//            self.bodyView.frame = self.keyboardShowBodyViewRect
//        })
        self.bodyView.frame = self.keyboardShowBodyViewRect
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        print("hide")
//        UIView.animate(withDuration: 1.0 , delay: 0.1, animations: {
//            self.bodyView.frame = self.keyboardHideBodyViewRect
//        })
//        self.bodyView.frame = self.keyboardShowBodyViewRect

        self.bodyView.frame = self.keyboardHideBodyViewRect
    }
        
    
    func checkOpen(data:String){
        DispatchQueue.main.sync {
            let alertView = GroupShareImportCheckViewController()
            alertView.data = data
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func exit(){
        delegate?.dismissDialog()
    }
    
    func errorDialog(){
        self.exit()
        let alert: UIAlertController = UIAlertController(title: "取得失敗", message: "辞典の取得に失敗しました。コードが間違っているか、インターネットに接続されていないか、サーバー側に問題があります。", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func append(){
        startIndicator()
        let res = codeTextField.text!
        let api = ShareAPI()
        api.get(id: res, result: {(res: ShareAPI.Result, data: String) in
            if res == .ok{
                DispatchQueue.main.sync {
                    self.dismissIndicator()
                }
                self.checkOpen(data:data)
            }else{
                if Thread.isMainThread{
                    self.errorDialog()
                }else{
                    DispatchQueue.main.sync {
                        self.errorDialog()
                    }
                }

            }
            })

    }
    @IBAction func cancel(){
        exit()
    }




}
