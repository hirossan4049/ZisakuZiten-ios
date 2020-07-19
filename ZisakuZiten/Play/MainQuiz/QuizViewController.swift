//
//  QuizViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/19.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

protocol SwipeBackable {
    func setSwipeBack()
}


class QuizViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

//        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back(){
//        navigationController?.popViewController(animated: true)
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

