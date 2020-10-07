//
//  CategoryColorButton.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/26.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation
import UIKit


class CategoryColorButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }
    
}

extension CategoryColorButton{
    internal func commonInit(){
        self.layer.cornerRadius = 14
    }
}
