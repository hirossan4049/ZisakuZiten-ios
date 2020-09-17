//
//  AudioPlayTableViewCell.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/16.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class AudioPlayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var playButton:UIButton!
    
    var index:Int!
    
    var isPlaying = false{
        didSet{
            if isPlaying{
                playButton.setBackgroundImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
                self.backgroundColor = .buttonBaseColor
            }else{
                playButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
                self.backgroundColor = .groupCellColor
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 13
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
