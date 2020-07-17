//
//  CategoryEditTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/24.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class CategoryEditTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var used_countLabel:UILabel!
    
    @IBOutlet weak var itemTagBodyView:UIView!
    @IBOutlet weak var itemTagHeadView:UIView!

    @IBOutlet var editButton:UIButton!

    var categoryCreateTime:Date!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemTagBodyView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
