//
//  GroupTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import SwipeCellKit

//class GroupTableViewCell: UITableViewCell {
class GroupTableViewCell: SwipeTableViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
//    @IBOutlet var cateColorView: UIView!
    @IBOutlet var categoryBodyColorView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryBodyColorView.layer.cornerRadius = 7
//        categoryBodyColorView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        // thanks https://qiita.com/hachinobu/items/dc2ff32fa2be6b78ea86
//        layerMinXMinYCorner    左上
//        layerMaxXMinYCorner    右上
//        layerMinXMaxYCorner    左下
//        layerMaxXMaxYCorner    右下
        
        self.backgroundColor =  .backgroundColor
        self.categoryBodyColorView.backgroundColor = .groupCellColor
        titleLabel.textColor = .baseTextColor
        
        // 影の方向（width=右方向、height=下方向、CGSize.zero=方向指定なし）
        categoryBodyColorView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        // 影の色
        categoryBodyColorView.layer.shadowColor = UIColor.black.cgColor
        // 影の濃さ
        categoryBodyColorView.layer.shadowOpacity = 0.3
        // 影をぼかし
        categoryBodyColorView.layer.shadowRadius = 2
        
        titleLabel.font = UIFont(name: "KosugiMaru", size: 17)
        
        categoryLabel.layer.cornerRadius = 100
        categoryLabel.backgroundColor = UIColor.red

//        self.CELL_HIGHT = self.bounds.height
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
