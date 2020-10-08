//
//  ZitenTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class ZitenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var bodyView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .none
        
        bodyView.layer.cornerRadius = 13

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
