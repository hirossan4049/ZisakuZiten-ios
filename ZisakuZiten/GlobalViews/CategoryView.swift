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
        
        self.layer.cornerRadius = 10
//        let nib = UINib(nibName: "CategoryView", bundle: nil)
//        self.addSubview(nib.instantiate(withOwner: self, options: nil).first as! UIView)
        
        
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
        self.addSubview(view)
    }
    

}
