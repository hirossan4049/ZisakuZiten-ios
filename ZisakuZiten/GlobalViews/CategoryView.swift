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
    @IBOutlet weak var categoryColorView:UIImageView!

    
    // override func draw(_ rect: CGRect) {

    // }

    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()

    }
    
    func resetView(){
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.mainLabel.frame.width - 15, height: self.frame.height)
//        self.frame = CGRect(x: 0, y: 0, width: self.mainLabel.frame.width + 60, height: self.frame.height)
//        self.backgroundColor = .cyan
    }

    func loadNib(){
        let view = Bundle.main.loadNibNamed("CategoryView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
//        self.backgroundColor = .none

        print(self.frame)
        resetView()
        self.addSubview(view)
        resetView()
        print(self.subviews)

    }
    

}
