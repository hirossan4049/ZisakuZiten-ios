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
        tabBar.unselectedItemTintColor = .white
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
        
        let images = ["homeicon","checkicon","userdataicon","settingicon"]

        var offset: CGFloat = 1.0

        if #available(iOS 11.0, *), traitCollection.horizontalSizeClass == .regular {
            offset = 0.0
        }
//        self.setTabBarItem(index: 0, titile: "ホーム", image: UIImage(named: "settingicon")!, selectedImage: UIImage(named: "settingicon")!, offColor: UIColor.blue, onColor: UIColor.red)

        if let items = tabBar.items {
            for (index,item) in items.enumerated() {
                item.title = ""
                item.image = UIImage(named: images[index])?.resize(size: CGSize(width: 23, height: 23))
                
//                print(item.image?.accessibilityIdentifier)
//                item.selectedImage = UIImage(named: images[index])?.resize(size: CGSize(width: 25, height: 25))
                item.selectedImage = UIImage(named: images[index] + "Bold")?.resize(size: CGSize(width: 25, height: 25))

                item.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
            }
        }
    }
    
    func setTabBarItem(index: Int, titile: String, image: UIImage, selectedImage: UIImage,  offColor: UIColor, onColor: UIColor) -> Void {
        let tabBarItem = self.tabBarController?.tabBar.items![index]
        tabBarItem!.title = titile
        tabBarItem!.image = image.withRenderingMode(.alwaysOriginal)
        tabBarItem!.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        tabBarItem!.setTitleTextAttributes([ .foregroundColor : offColor], for: .normal)
        tabBarItem!.setTitleTextAttributes([ .foregroundColor : onColor], for: .selected)
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
