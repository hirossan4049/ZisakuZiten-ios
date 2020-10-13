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
        self.view.backgroundColor = .backgroundColor
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
//        self.view.layer.masksToBounds = false
//        self.view.layer.shadowOffset = CGSize(width: 3, height: 3)
//        self.view.layer.shadowColor = UIColor.black.cgColor
//        self.view.layer.shadowRadius = 3.0
//        self.view.layer.shadowOpacity = 1.0
        // Do any additional setup after loading the view.
    }
    

}
