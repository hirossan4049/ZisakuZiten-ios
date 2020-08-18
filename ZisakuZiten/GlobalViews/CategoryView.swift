//
//  CategoryView.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/18.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit


class CategoryView: UIView {

    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        print("THISI IS CATEGORY VIEW. DRAWD VIEW. DOU?")
        
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()

    }

    func loadNib(){
        let view = Bundle.main.loadNibNamed("CategoryView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.layer.cornerRadius = 3
        self.layer.cornerRadius = 3

        self.addSubview(view)
        print(self.subviews)

    }
    

}
