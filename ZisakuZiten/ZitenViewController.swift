//
//  ZitenViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class ZitenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    let cellReuseIdentifier = "cell"
    var group_createTime:Date!
    var ziten_list: List<Ziten>!
    @IBOutlet var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ZitenTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        print("texttexttext",group_createTime)

        let realm = try! Realm()
        self.ziten_list = realm.objects(Group.self).filter("createTime==%@", group_createTime)[0].ziten_upT_List

    }
    
    @IBAction
    func back_on_press(){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func create_on_press(){
        self.performSegue(withIdentifier: "toCreateZiten", sender: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZitenTableViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true

        cell.titleLabel.text = "zitenzitenziten"
        cell.contentLabel.text = "fafafa"
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked!", indexPath.section)

    }
}
