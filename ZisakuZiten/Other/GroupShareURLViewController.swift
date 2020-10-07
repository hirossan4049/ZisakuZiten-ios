//
//  GroupShareURLViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/07.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class GroupShareURLViewController: UIViewController {
    var delegate: ViewController?

    @IBOutlet weak var bodyView:UIView!
    
    @IBOutlet weak var codeLabel:UILabel!
    @IBOutlet weak var deleteLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bodyView.layer.cornerRadius = 13
        self.view.backgroundColor = UIColor(hex: "000000",alpha: 0.3)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func codeCopy(){
        UIPasteboard.general.string = codeLabel.text
    }
    @IBAction func deleteCopy(){
        UIPasteboard.general.string = deleteLabel.text
    }
    
    @IBAction func exit(){
        delegate?.dismissDialog()
    }




}