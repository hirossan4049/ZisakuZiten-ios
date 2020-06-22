//
//  CreateZitenViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/22.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class CreateZitenViewController: UIViewController {
    
    var groupUpdateTime: Date?
    

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func ok_on_press() {

    }

    @IBAction func cancel_on_press() {
        self.dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        outputText.text = inputText.text
        print("touchesBegan")
        self.view.endEditing(true)
    }

}
