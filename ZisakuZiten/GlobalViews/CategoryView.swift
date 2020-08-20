//
//  CategoryView.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/18.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit


class CategoryView: UIView {
    @IBOutlet weak var mainLabel:UILabel!

    
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
        view.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
//        self.backgroundColor = .none
        print(self.frame)
        print(self.mainLabel.frame.width)
        print(self.mainLabel.font.pointSize)
        print(self.mainLabel.text)
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.mainLabel.frame.width + 30, height: self.frame.height)
        view.frame = CGRect(x: 0, y: 0, width: self.mainLabel.frame.width + 30, height: self.frame.height)
        self.backgroundColor = .cyan
        print(self.frame)
        
        self.addSubview(view)
        print(self.subviews)

    }
    

}
