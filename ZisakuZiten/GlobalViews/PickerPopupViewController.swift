//
//  PickerPopupViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/17.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class PickerPopupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var pickerView:UIPickerView!
    
    @IBOutlet weak var navigationBar:UINavigationBar!
//    @IBOutlet weak var doneButton:UIButton!
    
    var dataList = Array<String>()
    var selected_item:String!
//    var dataList = ["test","het"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        navigationBar.barTintColor = .backgroundColor
        pickerView.backgroundColor = .backgroundColor

        backView.layer.cornerRadius = 10
        selected_item = dataList[0]
    }
    
    @IBAction func done(){
        post()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func post(){
        let postArgs:[String: String] = ["selected": selected_item]
        NotificationCenter.default.post(name: Notification.Name("toExitPickerPopup"),object: nil,userInfo: postArgs)
    }


    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        print("sele.cted",dataList[row])
        selected_item = dataList[row]
//        label.text = dataList[row]
        
    }
}
