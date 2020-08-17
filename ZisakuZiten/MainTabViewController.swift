//
//  MainTabViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/23.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor(hex: "17122B")
        tabBar.tintColor = UIColor.white
        
        
        if let items = tabBar.items {
            for item in items {
                item.title = ""
//                item.imageInsets = UIEdgeInsets(top: 30, left: 0, bottom: -30, right: 0)//???
                let viewTabBar = tabBarItem.value(forKey: "view") as? UIView

                let  imgView = viewTabBar?.subviews[0] as? UIImageView
                viewTabBar?.frame.origin.y = 10
                imgView?.frame.size.height = 24
                imgView?.frame.size.width = 24
                imgView?.clipsToBounds = true
                imgView?.contentMode = .scaleAspectFit
            }
        }

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
