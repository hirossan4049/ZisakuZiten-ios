//
//  PlayNavigationController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/23.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class PlayNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
//    @IBOutlet var navigationController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer?.delegate = self
        self.navigationBar.backgroundColor = .navigationBarColor
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
//        self.view.layer.masksToBounds = false
//        self.view.layer.shadowOffset = CGSize(width: 3, height: 3)
//        self.view.layer.shadowColor = UIColor.black.cgColor
//        self.view.layer.shadowRadius = 3.0
//        self.view.layer.shadowOpacity = 1.0
        // Do any additional setup after loading the view.
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
