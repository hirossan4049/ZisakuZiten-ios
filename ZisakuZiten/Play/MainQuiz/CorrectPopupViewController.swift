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
    weak var img:UIImage!
    
    var isCorrect:Bool = false{
        didSet{
            if isCorrect{
                self.img = UIImage(named: "correctImg")
            }else{
                self.img = UIImage(named: "incorrectImg")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        imageView.image = img
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
