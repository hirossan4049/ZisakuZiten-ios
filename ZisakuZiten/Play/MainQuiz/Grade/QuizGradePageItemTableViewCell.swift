//
//  QuizGradePageItemTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/13.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class QuizGradePageItemTableViewCell: UITableViewCell {
    @IBOutlet weak var mainLabel:UILabel!
    @IBOutlet weak var iscorrectImg:UIImageView!
//    var labeltext:String!
    var img:UIImage!
    
    var isCorrect:Bool = false{
        didSet{
            if isCorrect{
                self.img = UIImage(named: "correctImg")
            }else{
                self.img = UIImage(named: "incorrectImg")
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 12
//        self.mainLabel.text = labeltext
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iscorrectImg.image = img
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
