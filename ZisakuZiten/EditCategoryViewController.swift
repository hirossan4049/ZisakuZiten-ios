//
//  EditCategoryViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/24.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class EditCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var tableView: UITableView!
    var categoryList: Results<Category>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CategoryEditTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let realm = try! Realm()
        categoryList = realm.objects(Category.self)
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
         presentingViewController?.beginAppearanceTransition(false, animated: animated)
         super.viewWillAppear(animated)
        
        print("ViewWIllPAPPEER")
     }
    

    @IBAction func createCatPrs() {
        let alertView = CreateCategoryDialogViewController()
        alertView.modalTransitionStyle = .crossDissolve
//        alertView.modalPresentationStyle = .fullScreen
        present(alertView, animated: true, completion: nil)
        print("CreateCatPress")
    }

//MEMO [SwiftでUITableViewCellの中にUIButtonを置いてタッチイベントを取得] (https://qiita.com/nmisawa/items/6ffbe6b3c7f2c474c74f)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOFSection",self.categoryList.count)
        return self.categoryList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryEditTableViewCell
        
        let category:Category = self.categoryList[indexPath.section]
        cell.titleLabel.text = category.title!
        cell.itemTagHeadView.backgroundColor = UIColor(hex: category.colorCode!,alpha: 1)
        cell.itemTagBodyView.backgroundColor = UIColor(hex: category.colorCode!,alpha: 0.2)
        
        return cell

    }

    // spacing 間隔
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("SPACING IN ROW")
        return 10
    }
    // 背景透けるように
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }


}
