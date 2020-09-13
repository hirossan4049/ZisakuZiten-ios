//
//  SelectCategoryTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/12.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class SelectCategoryTableViewCell: UITableViewCell {
    
//    var categoryColor = "FF4B4B"
    var categoryColor = "000000"

    @IBOutlet weak var categoryColorView:UIView!
    @IBOutlet weak var checkImgView:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor(hex: "000000",alpha: 0.1)
//        self.categoryColorView.backgroundColor = UIColor(hex: categoryColor)
        
        categoryColorView.layer.cornerRadius = categoryColorView.frame.size.width/2
        checkImgView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("SET SELECTED",selected)
        if selected{
            self.backgroundColor = UIColor(hex: categoryColor,alpha: 0.4)
            self.checkImgView.tintColor = UIColor(hex: categoryColor)
            self.checkImgView.isHidden = false
        }else{
            self.backgroundColor = UIColor(hex: "000000",alpha: 0.1)
            self.checkImgView.isHidden = true
        }
        // Configure the view for the selected state
    }
    
}
