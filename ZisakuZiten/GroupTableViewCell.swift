//
//  GroupTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var cateColorView: UIView!
    @IBOutlet var categoryBodyColorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryBodyColorView.layer.cornerRadius = 10
        categoryBodyColorView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        cateColorView.layer.cornerRadius = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
