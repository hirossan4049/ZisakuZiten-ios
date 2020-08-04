//
//  isCorrectPopupViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/04.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class isCorrectPopupViewController: UIViewController {
    @IBOutlet weak var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "correctImg")
        self.view.layer.cornerRadius = 7
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
