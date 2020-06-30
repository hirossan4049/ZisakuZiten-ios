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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CategoryEditTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func createCatPrs() {
        let alertView = CreateCategoryDialogViewController()
        present(alertView, animated: true, completion: nil)
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryEditTableViewCell
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
