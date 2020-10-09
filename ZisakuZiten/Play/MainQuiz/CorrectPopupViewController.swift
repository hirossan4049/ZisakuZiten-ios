//
//  isCorrectPopupViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/04.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class CorrectPopupViewController: UIViewController {
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var backgroundView:UIView!
    @IBOutlet weak var textLabel:UILabel!
    var img:UIImage!
    var text:String = ""
    
    var isCorrect:Bool = false{
        didSet{
            if isCorrect{
                self.img = UIImage(named: "correctImg")
                self.text = "正解"
            }else{
                self.img = UIImage(named: "incorrectImg")
                self.text = "不正解"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        imageView.image = img
        textLabel.text = text
        
        self.backgroundView.backgroundColor = .backgroundColor
        self.textLabel.textColor = .baseTextColor
        
//        self.backgroundView.addBlur()
        self.backgroundView.layer.cornerRadius = 10

    
    }
    
    


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
