//
//  ZitenViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

@available(iOS 11.0, *)
class ZitenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    let cellReuseIdentifier = "cell"
    var group_createTime:Date!
    var ziten_list: List<Ziten>!

    var ziten_editor_mode:Int = 0
    var edit_ziten_createTime:Date!
    
    var PREVIEW_MODE = false

    @IBOutlet var createBtn: UIButton!
    @IBOutlet var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ZitenTableViewCell", bundle: nil)
        print("Ziten Nib",nib)
        self.view.backgroundColor = .white

        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        self.view.backgroundColor = .backgroundColor
        self.tableView.backgroundColor =  .backgroundColor

        tableView.delegate = self
        tableView.dataSource = self
        
        let realm = try! Realm()
        let group = realm.objects(Group.self).filter("createTime==%@", group_createTime!)[0]
        self.ziten_list = group.ziten_upT_List
        self.title = group.title
        
        self.tableView.separatorStyle = .none

        
        if PREVIEW_MODE{
            self.createBtn.isHidden = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentingViewController?.endAppearanceTransition()
        tableView.reloadData()
    }
    
    @IBAction
    func back_on_press(){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func create_on_press(){
        self.ziten_editor_mode = 0
        self.performSegue(withIdentifier: "toCreateZiten", sender: nil)
    }



    // List item の数。
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.ziten_list.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as GroupTableViewCell!
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZitenTableViewCell
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderColor = UIColor(hex: "878787").cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true

        let ziten:Ziten = self.ziten_list[indexPath.section]
        cell.titleLabel.text = ziten.title
        cell.contentLabel.text = ziten.content
        return cell
    }

    // spacing 間隔
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return -3
    }

    // 背景透けるように
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    // 右から左へスワイプ
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal,
                title: "Edit",
                handler: {(action: UIContextualAction, view: UIView, completion: (Bool) -> Void) in
                    print("Edit")
                    // 処理を実行完了した場合はtrue
                    self.ziten_editor_mode = 1
                    self.edit_ziten_createTime = self.ziten_list[indexPath.section].createTime
                    self.performSegue(withIdentifier: "toCreateZiten", sender: nil)
                    completion(true)
                })
        editAction.backgroundColor = UIColor(red: 101/255.0, green: 198/255.0, blue: 187/255.0, alpha: 1)

        let deleteAction = UIContextualAction(style: .destructive,
                title: "Delete",
                handler: { (action: UIContextualAction, view: UIView, completion: (Bool) -> Void) in
                    print("Delete")
                    // 処理を実行できなかった場合はfalse
                    let realm = try! Realm()
                    try! realm.write{
                        self.ziten_list.remove(at: indexPath.section)
                    }
                    completion(true)
                    tableView.reloadData()
                })
        deleteAction.backgroundColor = UIColor(red: 214/255.0, green: 69/255.0, blue: 65/255.0, alpha: 1)

        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    // onpress
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked!", indexPath.section)
        tableView.deselectRow(at: indexPath, animated: true)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateZiten" {
            let nextVC = segue.destination as! CreateZitenViewController
            //ただただ作成するだけなら別にいいよね（）
            nextVC.group_createTime = self.group_createTime
            if self.ziten_editor_mode == 1{
                nextVC.mode = self.ziten_editor_mode
                nextVC.ziten_createTime = self.edit_ziten_createTime
            }
        }
    }
}
