//
//  QuizinCorrectCountPageItemViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/13.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import Foundation

class QuizinCorrectCountPageItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
    
    var finished_list:[Ziten]! = []
    var finished_isCorrectList:[Bool] = []
    var incorrect_countAZ:[[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .textFieldBackgroundColor
        self.view.layer.cornerRadius = 13
        self.tableView.layer.cornerRadius = 13
        
        let cell = UINib(nibName: "QuizinCorrectCountPageTableViewCell", bundle: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cell, forCellReuseIdentifier: "cell")


        // sort
//        print(incorrectList.sort(by: {$0.createTime! > $1.createTime!}))
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //間違えたやつだけ抽出
        var incorrectList:[Ziten] = []
        for (i,v) in finished_isCorrectList.enumerated(){
            if !v{
                incorrectList.append(self.finished_list[i])
            }
        }
        //間違えたやつ、何回間違えたか。
        while true {
            let tmp_ziten = incorrectList.first
            let tmp_createTime = tmp_ziten?.createTime
            if tmp_createTime == nil{
                print("ニラ")
                break
            }
            var tmp_counter = 0
            var tmp_removeint:[Int] = []
            for (i,v) in incorrectList.enumerated(){
                if v.createTime == tmp_createTime{
                    tmp_counter += 1
                    tmp_removeint.append(i)
                }
            }
            print("uhehe",tmp_removeint.count,incorrectList.count)
            for (i,v) in tmp_removeint.enumerated(){ print(i);incorrectList.remove(at: v-i) }
            print("matigaetayatu",tmp_ziten?.title,tmp_counter)
            incorrect_countAZ.append([String(tmp_ziten!.title!),String(tmp_counter) + "回"])
        }
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incorrect_countAZ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! QuizinCorrectCountPageTableViewCell
        let tmp_list = incorrect_countAZ[indexPath.row]
        cell.mainLabel.text = tmp_list[0]
        cell.countLabel.text = tmp_list[1]
        return cell
    }
    
}
