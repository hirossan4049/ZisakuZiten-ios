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
    var clicked_group: Group!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View controller")
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "GroupTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        let realm = try! Realm()
        self.groupList = realm.objects(Group.self)
        print(groupList)
        print(realm.objects(Category.self))


        // 3D Touchが使える端末か確認
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            // どのビューをPeek and Popの対象にするか指定
            registerForPreviewing(with: self, sourceView: tableView)
//            registerForPreviewing(with: self, sourceView: view)
        }
    }

    @IBAction
    func createGroup_on_press() {
        ///FIXME: category
        createGroupDialog()
    }
    @IBAction func createCategory_on_press(){
        self.performSegue(withIdentifier: "toCategoryEdit", sender: nil)
//        let alertView = CreateCategoryDialogViewController(title: "type1AlertView", desc: "説明文はここに入れます。")
//        present(alertView, animated: true, completion: nil)
    }

    func createCategoryDialog(){
        
    }

    func updateGroupDialog(title: String, id: Int) {
        var alertTextField: UITextField?
        let alert = UIAlertController(
                title: "グループを編集",
                message: "グループの名前を入力してください",
                preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(
                configurationHandler: { (textField: UITextField!) in
                    textField.text = title
                })
        alertTextField = alert.textFields![0] as UITextField
        alert.addAction(
                UIAlertAction(
                        title: "Cancel",
                        style: UIAlertAction.Style.cancel,
                        handler: nil))
        alert.addAction(
                UIAlertAction(
                        title: "OK",
                        style: UIAlertAction.Style.default) { _ in

                    if let text = alertTextField?.text {
                        print("UpdateDialogOK: " + text)
                        self.updateGroup(title: text, id: id)
                        self.tableView.reloadData()
                    }
                }
        )
        self.present(alert, animated: true, completion: nil)
    }

    func createGroupDialog() {
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

    func createGroup(title: String) {
        let instanceGroup: Group = Group()
        let now = Date()
        instanceGroup.title = title
        instanceGroup.createTime = now
        instanceGroup.updateTime = now
//        instanceGroup.category
        let insRealm = try! Realm()
        try! insRealm.write {
            insRealm.add(instanceGroup)
        }
    }

    func updateGroup(title: String, id: Int) {
        let realm = try! Realm()
        try! realm.write {
            groupList[id].title = title
        }
        print("updateGroup saved")
    }

    func deleteGroup(id: Int) {
        let dialog = UIAlertController(title: "グループを消去", message: "単語も消去されます。本当に消去しますか？", preferredStyle: .actionSheet)
        let realm = try! Realm()
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            try! realm.write {
                realm.delete(self.groupList[id])
            }
            self.tableView.reloadData()
        }))
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 生成したダイアログを実際に表示します
        self.present(dialog, animated: true, completion: nil)
    }

    // https://www.it-swarm.dev/ja/ios/uitableviewcell%E3%81%AE%E9%96%93%E9%9A%94%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95/972967975/
    
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
//        cell.backgroundColor = UIColor.white
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderColor = UIColor.white.cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
//        cell.clipsToBounds = true
        
//        // 影の方向（width=右方向、height=下方向、CGSize.zero=方向指定なし）
//        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        // 影の色
//        cell.layer.shadowColor = UIColor.black.cgColor
//        // 影の濃さ
//        cell.layer.shadowOpacity = 0.6
//        // 影をぼかし
//        cell.layer.shadowRadius = 4

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
        return 2
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
                handler: { (action: UIContextualAction, view: UIView, completion: (Bool) -> Void) in
                    print("Edit")
                    // 処理を実行完了した場合はtrue
                    self.updateGroupDialog(title: self.groupList[indexPath.section].title!, id: indexPath.section)
                    completion(true)
                })
        editAction.backgroundColor = UIColor(red: 101 / 255.0, green: 198 / 255.0, blue: 187 / 255.0, alpha: 1)

        let deleteAction = UIContextualAction(style: .destructive,
                title: "Delete",
                handler: { (action: UIContextualAction, view: UIView, completion: (Bool) -> Void) in
                    print("Delete")
                    // 処理を実行できなかった場合はfalse
                    self.deleteGroup(id: indexPath.section)

                    completion(false)
                })
        deleteAction.backgroundColor = UIColor(red: 214 / 255.0, green: 69 / 255.0, blue: 65 / 255.0, alpha: 1)

        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    // onpress
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked!", indexPath.section)
        self.clicked_group = self.groupList[(indexPath as IndexPath).section]
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toZiten") as? ZitenViewController
//        self.present(secondViewController!, animated: true, completion: nil)

//        let nextView = storyboard?.instantiateViewController(withIdentifier: "ZitenViewController") as! UINavigationController
//           self.present(nextView, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)

        self.performSegue(withIdentifier: "toZiten", sender: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toZiten" {
            let nextVC = segue.destination as! ZitenViewController
            nextVC.group_createTime = self.clicked_group.createTime
        }
    }


}


extension ViewController: UIViewControllerPreviewingDelegate {
    // Peek
    @available(iOS 10.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return nil
        }
//        return ZitenPreviewViewController(indexPath: indexPath)
//        let clicked = self.groupList[(indexPath as IndexPath).section]
//        return ZitenViewController(group_createTime: clicked.createTime!)
        return nil
    }

    // Pop
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
