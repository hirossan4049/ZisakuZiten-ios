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
        
        tabBar.barTintColor = .tabBarColor
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = .tabBarColor
//        tabBar.frame.size = CGSize(width: 3, height: 1)
        
        removeTabbarItemsText()
        
//        if let items = tabBar.items {
//            for item in items {
//                item.title = ""
////                item.imageInsets = UIEdgeInsets(top: 30, left: 0, bottom: -30, right: 0)//???
//                let viewTabBar = tabBarItem.value(forKey: "view") as? UIView
//                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
////                let  imgView = viewTabBar?.subviews[0] as? UIImageView
////                viewTabBar?.frame.origin.y = 10
////                imgView?.frame.size.height = 30
////                imgView?.frame.size.width = 24
////                imgView?.frame = CGRect(x: imgView!.frame.origin.x, y: imgView!.frame.origin.y + 10, width: imgView!.frame.width, height: imgView!.frame.height)
////                imgView?.clipsToBounds = true
////                imgView?.contentMode = .scaleAspectFit
//            }
//        }

        // Do any additional setup after loading the view.
    }
    
    func removeTabbarItemsText() {

        var offset: CGFloat = 6.0

        if #available(iOS 11.0, *), traitCollection.horizontalSizeClass == .regular {
            offset = 0.0
        }

        if let items = tabBar.items {
            for item in items {
                print("foofoofofo")
                item.title = ""
                item.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
            }
        }
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
