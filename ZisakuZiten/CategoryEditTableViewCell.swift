//
//  CategoryEditTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/24.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class CategoryEditTableViewCell: UITableViewCell {
    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var used_countTextField:UITextField!
    
    @IBOutlet weak var itemTagBodyView:UIView!
    @IBOutlet weak var itemTagHeadView:UIView!
    
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
