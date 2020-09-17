//
//  PickerPopupView.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/17.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class PickerPopupView: UIView, UIPickerViewDelegate {
    @IBOutlet weak var baseView:UIView!
    @IBOutlet weak var pickerView:UIPickerView!
    
    var dataList = ["hello"]
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        pickerView.delegate = self
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
        
//        label.text = dataList[row]
        // FIXME: Observer?
        
        
    }



}
