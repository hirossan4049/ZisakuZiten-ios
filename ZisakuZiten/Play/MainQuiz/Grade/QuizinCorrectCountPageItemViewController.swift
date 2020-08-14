//
//  QuizinCorrectCountPageItemViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/13.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class QuizinCorrectCountPageItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
    
    var finished_list:[Ziten]! = []
    var finished_isCorrectList:[Bool] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "FFF4A3")
        self.view.layer.cornerRadius = 13
        self.tableView.layer.cornerRadius = 13
        
        let cell = UINib(nibName: "QuizinCorrectCountPageTableViewCell", bundle: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cell, forCellReuseIdentifier: "cell")

        print("VIEWDIDLOAD",finished_isCorrectList)
        var incorrectList:[Ziten]!
        for (i,v) in finished_isCorrectList.enumerated(){
            print(i,v)
            if !v{
                print("間違えとる、")
                incorrectList.append(self.finished_list[i])
            }
        }
        // sort
//        print(incorrectList.sort(by: {$0.createTime! > $1.createTime!}))
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! QuizinCorrectCountPageTableViewCell
        return cell
    }
    
}
