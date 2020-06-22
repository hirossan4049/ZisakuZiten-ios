//
//  ViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    let cellReuseIdentifier = "cell"
    var groupList: Results<Group>!
    var clicked_group:Group!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "GroupTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        let realm = try! Realm()
        self.groupList = realm.objects(Group.self)
        print(groupList)

    }
    
    @IBAction
    func create_on_press(){
        ///FIXME: category
        createGroupDialog()
    }


    func createGroupDialog(){
        var alertTextField: UITextField?
        let alert = UIAlertController(
                title: "グループを作成",
                message: "作成したいグループの名前を入力してください",
                preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(
                configurationHandler: { (textField: UITextField!) in
                    textField.text = ""
                })
        alertTextField = alert.textFields![0] as UITextField
        alert.addAction(
                UIAlertAction(
                        title: "Cancel",
                        style: UIAlertAction.Style.cancel,
                        handler: nil))
        alert.addAction(
                UIAlertAction(
                        title: "Create",
                        style: UIAlertAction.Style.default) { _ in

                    if let text = alertTextField?.text {
                        print("CreateDialogOK: " + text)
                        self.createGroup(title: text)
//                        self.tableView.beginUpdates()
//                        self.tableView.insertRows(at: [IndexPath(row: 0, section: self.groupList.count - 1)],
//                                with: .automatic)
//                        self.tableView.endUpdates()
                        self.tableView.reloadData()
                        //                        self.label1.text = text
                    }
                }
        )
        self.present(alert, animated: true, completion: nil)
    }

    func createGroup(title:String){
        let instanceGroup: Group = Group()
        let now = Date()
        instanceGroup.title = title
        instanceGroup.createTime = now
        instanceGroup.updateTime = now
//        instanceGroup.category
        let insRealm = try! Realm()
        try! insRealm.write{
            insRealm.add(instanceGroup)
        }
    }


    // List item の数。
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.groupList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as GroupTableViewCell!
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTableViewCell
        cell.backgroundColor = UIColor.white
//        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true

        let group: Group = self.groupList[(indexPath as IndexPath).section]
        print(group.title)
        print(group.updateTime)
        cell.titleLabel.text = group.title
        ///TODO:カテゴリ系の処理
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked!", indexPath.section)
        self.clicked_group = self.groupList[(indexPath as IndexPath).section]
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toZiten") as? ZitenViewController
//        self.present(secondViewController!, animated: true, completion: nil)

//        let nextView = storyboard?.instantiateViewController(withIdentifier: "ZitenViewController") as! UINavigationController
//           self.present(nextView, animated: true, completion: nil)

        self.performSegue(withIdentifier: "toZiten", sender: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toZiten" {
            let nextVC = segue.destination as! ZitenViewController
            nextVC.group_createTime = self.clicked_group.createTime
        }
    }


}

