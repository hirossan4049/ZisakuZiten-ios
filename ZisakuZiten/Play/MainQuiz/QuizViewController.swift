//
//  QuizViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/29.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class QuizViewController: PlayBaseViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_settings()
        mainLabel.adjustsFontSizeToFitWidth = true
        // ScrollViewどうしよ
        mainLabel.text = "絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる絶対王政（ぜったいおうせい、英語: absolute monarchism）は、王が絶対的な権力を行使する政治の形態を指す。 絶対主義や絶対君主制とも呼ばれる。"
        // Do any additional setup after loading the view.
    }
    
    func btn_settings(){
        btn1.layer.cornerRadius = 13
        btn2.layer.cornerRadius = 13
        btn3.layer.cornerRadius = 13
        btn4.layer.cornerRadius = 13

    }
    
    @IBAction func exit(){
        self.dismiss(animated: true, completion: nil)
    }



}
