//
//  PlayStartViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/25.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class PlayStartViewController: UIViewController {
    
    @IBOutlet weak var groupSelectView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(groupPickerClicked(sender:)))
        print(tapGesture)
        groupSelectView.addGestureRecognizer(tapGesture)
        groupSelectView.layer.cornerRadius = 17
        groupSelectView.layer.borderColor = UIColor(hex: "EBEBEB").cgColor
        groupSelectView.layer.borderWidth = 1
        
        
        
        // Do any additional setup after loading the view.
    }
    

    @objc func groupPickerClicked(sender: UITapGestureRecognizer) {
        print("tap")
    }

}
