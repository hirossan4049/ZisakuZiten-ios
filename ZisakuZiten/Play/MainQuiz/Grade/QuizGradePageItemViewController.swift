//
//  QuizGradePageItemViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/13.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class QuizGradePageItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 13
        self.view.backgroundColor = .lightGray
        
        let nib = UINib(nibName: "QuizGradePageItemTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self


        // Do any additional setup after loading the view.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! QuizGradePageItemTableViewCell
        cell.mainLabel.text = "hellowww"
        cell.isCorrect = true
        return cell
    }
    
    
}
