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
