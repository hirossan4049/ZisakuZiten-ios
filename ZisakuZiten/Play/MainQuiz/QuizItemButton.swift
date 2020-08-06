//
//  QuizItemButton.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/06.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class QuizItemButton: UIButton {
    
    var base_color:UIColor!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        base_color = self.backgroundColor
        reset()
    }
    
    
    func reset(){
        self.layer.cornerRadius = 13
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 10
        
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.font = UIFont(name:"MotoyaLMaru", size: 20.0)
//        self.titleLabel!.textAlignment = .left
        self.contentHorizontalAlignment = .left
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        self.addTarget(self, action: #selector(touchUp(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUp(_:)), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        self.layer.cornerRadius = 27
//        self.backgroundColor = UIColor(hex: "FF9931")
    }
    
//    func btnStatus(isEnb:Bool){
//        self.isEnabled = isEnb
//        if isEnb{
//            self.backgroundColor = UIColor(hex: "FF9931")
//        }else{
//            self.backgroundColor = UIColor(hex: "D0D0D0")
//        }
//    }
    
    
    
    @objc func touchDown(_ sender:UIButton) {
        let baseRGBA = self.backgroundColor?.convertToRGBA()
        self.backgroundColor = UIColor(red: baseRGBA!.red - 0.1, green: baseRGBA!.green - 0.1, blue: baseRGBA!.blue - 0.1, alpha: baseRGBA!.alpha)

        
    }
    
    @objc func touchUp(_ sender:UIButton){
        self.backgroundColor = base_color
    }

}
