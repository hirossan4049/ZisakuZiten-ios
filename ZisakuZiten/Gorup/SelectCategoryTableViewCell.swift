//
//  SelectCategoryTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/12.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class SelectCategoryTableViewCell: UITableViewCell {
    
    var categoryColor = "FF4B4B"
    @IBOutlet weak var categoryColorView:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor(hex: "000000",alpha: 0.1)
        categoryColorView.layer.cornerRadius = categoryColorView.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("SET SELECTED",selected)
        if selected{
            self.backgroundColor = UIColor(hex: categoryColor,alpha: 0.4)
        }else{
            self.backgroundColor = UIColor(hex: "000000",alpha: 0.1)
        }
        // Configure the view for the selected state
    }
    
}
