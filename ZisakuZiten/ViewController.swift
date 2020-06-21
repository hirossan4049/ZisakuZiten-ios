//
//  ViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let cellReuseIdentifier = "cell"
    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "GroupTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
                
    }

    
    // List item の数。
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as GroupTableViewCell!
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTableViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        cell.titleLabel.text = "hello"
        cell.categoryLabel.text = "カテゴリ:その他"
        return cell
    }
    
      // spacing 間隔
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 10
      }

      // 背景透けるように
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let headerView = UIView()
          headerView.backgroundColor = UIColor.clear
          return headerView
      }
    
    // onpress
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("clicked!",indexPath.section)
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ZitenViewController") as? ZitenViewController
//        self.present(secondViewController!, animated: true, completion: nil)

           // ②遷移先NavigationControllerのインスタンス取得
           //   Navigation ControllerのStoryboard IDが"NC1"に設定されている例
           //   インスタンスのクラスはUINavigationController
//        let nextView = storyboard?.instantiateViewController(withIdentifier: "ZitenViewController") as! UINavigationController
//
//           // ③画面遷移（presentメソッドを使う）
//           self.present(nextView, animated: true, completion: nil)

        self.performSegue(withIdentifier: "toZiten", sender: nil)
        
    }
    


}

