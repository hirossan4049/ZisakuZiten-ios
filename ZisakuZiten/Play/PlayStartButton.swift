//
//  PlayStartButton.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/25.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

// 分ける必要ねぇか。
class PlayStartButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        reset()
    }
    
    
    func reset(){
        self.addTarget(self, action: #selector(touchUp(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUp(_:)), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        self.layer.cornerRadius = 27
        self.backgroundColor = UIColor(hex: "FF9931")
    }
    
    func btnStatus(isEnb:Bool){
        self.isEnabled = isEnb
        if isEnb{
            self.backgroundColor = UIColor(hex: "FF9931")
        }else{
            self.backgroundColor = UIColor(hex: "D0D0D0")
        }
    }
    
    
    
    @objc func touchDown(_ sender:UIButton) {
        self.backgroundColor = UIColor(hex: "DB8025")

        
    }
    
    @objc func touchUp(_ sender:UIButton){
        self.backgroundColor = UIColor(hex: "FF9931")
    }

}

