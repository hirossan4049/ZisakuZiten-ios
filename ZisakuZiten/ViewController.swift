//
//  ViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import AudioToolbox
import ViewAnimator
import AMScrollingNavbar

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate, UIViewControllerPreviewingDelegate, ScrollingNavigationControllerDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        print("PRESSED")
//        self.performSegue(withIdentifier: "toZiten", sender: nil)
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toZiten") as! ZitenViewController
        secondViewController.group_createTime = self.clicked_group.createTime
        self.navigationController?.pushViewController(secondViewController, animated: true)

    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        print("3D Touched!")
//        AudioServicesPlaySystemSound( 1102 )

        let indexPath = tableView.indexPathForRow(at: location)
        print(createBtn.bounds.contains(location))
        
        if (indexPath != nil){
            self.clicked_group = self.groupList[(indexPath! as IndexPath).section]
            print("in TableView 3DTouch")

            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toZiten") as! ZitenViewController
            secondViewController.PREVIEW_MODE = true
            secondViewController.group_createTime = self.clicked_group.createTime
            
            return secondViewController
            
        }else if(false){
            // floating button
            
        }else{
            return nil
        }

//
//        if let (url, rect) = tableView.frame.{
//            previewingContext.sourceRect = self.view.convert(rect, from: textView)
//            let controller = WebViewController(nibName: nil, bundle: nil)
//            controller.url = url
//            return controller
//        }
//        return nil
    }
    

    let cellReuseIdentifier = "cell"
    var groupList: Results<Group>!
    var clicked_group: Group!
    @IBOutlet var tableView: UITableView!
    @IBOutlet private weak var createBtn:UIButton!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var dController :UIDocumentInteractionController!
    var isBegin = true

    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View controller")
        self.view.backgroundColor = .backgroundColor
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "GroupTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .backgroundColor
        self.view.backgroundColor = .backgroundColor
        createBtn.backgroundColor = .floatingBtnColor

        let realm = try! Realm()
        self.groupList = realm.objects(Group.self)
        
                
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
//        print(groupList)
//        print(realm.objects(Category.self))
        
        self.tabBarItem.title = nil
            
        // 3D Touchが使える端末か確認
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            // どのビューをPeek and Popの対象にするか指定
            registerForPreviewing(with: self, sourceView: tableView)
//            registerForPreviewing(with: self, sourceView: view)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.cell_animation()
        }
    }
    
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
//        cell_animation()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        cell_animation()
        print("ViewDidApper")
        print(self.isBegin)
        if !self.isBegin{
            tableView.reloadData()
        }else{
            self.isBegin = false
        }
        if let navigationController = self.navigationController as? ScrollingNavigationController {
          if let tabBarController = tabBarController {
            navigationController.followScrollView(tableView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
          } else {
            navigationController.followScrollView(tableView, delay: 0.0, scrollSpeedFactor: 2)
          }
          navigationController.scrollingNavbarDelegate = self
          navigationController.expandOnActive = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func scrollingNavigationController(_ controller: ScrollingNavigationController, didChangeState state: NavigationBarState) {
      switch state {
      case .collapsed:
        print("navbar collapsed")
      case .expanded:
        print("navbar expanded")
      case .scrolling:
        print("navbar is moving")
      }
    }
    
    func cell_animation(){
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 0.0)
        let zoomAnimation = AnimationType.zoom(scale: 0.3)
        UIView.animate(views: tableView.visibleCells,
                       animations: [fromAnimation, zoomAnimation], delay: 0)
    }
    


    @IBAction
    func createGroup_on_press() {
        ///FIXME: category
//        createGroupDialog()
        createGroupDialog_new()
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
    
    func createGroupDialog_new(){
        let alertView = CreateGroupViewController()
        alertView.modalTransitionStyle = .crossDissolve
        alertView.modalPresentationStyle = .overCurrentContext
        present(alertView, animated: true, completion: nil)
        print("CreateCatPress")
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
    
    func editGroupDialog(createTime:Date){
        let alertView = CreateGroupViewController()
        alertView.modalTransitionStyle = .crossDissolve
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.createTime = createTime
        alertView.EDIT_MODE = true
        present(alertView, animated: true, completion: nil)
        print("CreateCatPress")
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
    
    func group2json(group:Group) -> String{
//                let mirror = Mirror(reflecting: self.groupList[(indexPath as IndexPath).section])
//                print("for back")
//                for child in mirror.children {
//                    print(child.label ?? "")
//        //            print(child.value)
//                    print(String(describing: type(of: child.value)))
//                    print(child.value == nil?)
        //            if child.value ?? as! Bool{
        //                print("this is nil")
        //            }else{
        //                print("not nil, value :",child.value)
        //            }
//                }
        var zitenList:[[String:Any]] = []
        var groupDict:[String:Any] = [:]
        groupDict["title"] = group.title
        groupDict["createTime"] = group.createTime?.toString()
        for ziten in group.ziten_upT_List{
            var zitenDict:[String:Any] = [:]
            zitenDict["title"] = ziten.title
            zitenDict["content"] = ziten.content
            zitenDict["updateTime"] = ziten.createTime?.toString()
            zitenList.append(zitenDict)
        }
        groupDict["ziten_updT_List"] = zitenList
        
        let jsonData = try! JSONSerialization.data(withJSONObject: groupDict, options: [])
        let jsonStr = String(bytes: jsonData, encoding: .utf8)!
//        print(jsonStr)
//        let data = jsonStr!.data(using: .utf8)!
//        let obj = try! JSONSerialization.jsonObject(with: jsonData, options: [])
//        let myData = Group(value: obj)
//        print(myData)
        return jsonStr
    }
    
    func saveFile(filename:String,data:String){
    //        // ファイル一時保存してNSURLを取得
           let url2 = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filename)!
           do{
               try data.write(to: url2,atomically: true, encoding: String.Encoding.utf8)
           }catch{
               print("データ保存でエラー")
               return
           }

           dController = UIDocumentInteractionController.init(url: url2)
            if !(dController.presentOpenInMenu(from: CGRect(x: 0, y: 0, width: 500, height: 300), in: self.view, animated: true)) {
               print("ファイルに対応するアプリがない")
           }
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
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.red
        cell.selectedBackgroundView = selectionView
        
        var logo = UIImage(named: "testTitleImg.png")
        logo = logo?.resize(size: CGSize(width: 200, height: 40))
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        cell.delegate = self
        
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
        cell.categoryLabel.text = "その他"
        return cell
    }

    // spacing 間隔
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

    // 背景透けるように
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

//    // 右から左へスワイプ
//    @available(iOS 11.0, *)
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let editAction = UIContextualAction(style: .normal,
//                title: "Edit",
//                handler: { (action: UIContextualAction, view: UIView, completion: (Bool) -> Void) in
//                    print("Edit")
//                    // 処理を実行完了した場合はtrue
//                    self.updateGroupDialog(title: self.groupList[indexPath.section].title!, id: indexPath.section)
//                    completion(true)
//                })
//        editAction.backgroundColor = UIColor(red: 101 / 255.0, green: 198 / 255.0, blue: 187 / 255.0, alpha: 1)
//
//        let deleteAction = UIContextualAction(style: .destructive,
//                title: "Delete",
//                handler: { (action: UIContextualAction, view: UIView, completion: (Bool) -> Void) in
//                    print("Delete")
//                    // 処理を実行できなかった場合はfalse
//                    self.deleteGroup(id: indexPath.section)
//
//                    completion(false)
//                })
//        deleteAction.backgroundColor = UIColor(red: 214 / 255.0, green: 69 / 255.0, blue: 65 / 255.0, alpha: 1)
//        
//
//        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
//    }

//    
    // CELL EDIT
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        print("CELL EDIT")
        print(indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTableViewCell
        let group = self.groupList[(indexPath as IndexPath).section]
//        print(zitenList,self.groupList[(indexPath as IndexPath).section])
//        let data = JSONSerialization.dataWithJSONObject(zitenList, options: nil, error: nil)
//        let string = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(string)
    
        
        let row = tableView.cellForRow(at: indexPath)
        let cellHeight = (row?.bounds.height)!

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in 
            action.fulfill(with: .reset)
            self.deleteGroup(id: (indexPath as IndexPath).section)
            print("DELETE")
        }
        let editAction = SwipeAction(style: .destructive, title: "Edit") { action, indexPath in
            self.editGroupDialog(createTime: group.createTime!)
        }
        let tagAction = SwipeAction(style: .destructive, title: "share") { action, indexPath in
            let jsondata = self.group2json(group: group)
            let filename = group.title! + ".json"
            self.saveFile(filename: filename, data: jsondata)
        }
//        let btn:CategoryColorButton = CategoryColorButton()
//        btn.backgroundColor = .red
//        btn.tintColor = .green
        
//        btn.setTitle("削除", for: .normal)
//        btn.frame.size = CGSize(width: 80, height: 35)
//        btn.backgroundColor = .red
        
//        let img = UIImage(named: "del_sample")
//        let img = btn.asImage()
                
//        let resized_img = img.resize(size: CGSize(width: cellHeight + 10, height: cellHeight))
        deleteAction.transitionDelegate = ScaleTransition.default
        
//        deleteAction.image = UIImage(named: "del_sample")
        
//        deleteAction.image = btn.asImage()
        var deleteimg = UIImage(named: "deleteicon")
        deleteimg = deleteimg?.resize(size: CGSize(width: 40, height: 40))
        deleteAction.image = deleteimg
        deleteAction.title = nil
//        deleteAction.backgroundColor = UIColor(hex: "32005D")
        deleteAction.backgroundColor = .backgroundColor

        var editimg = UIImage(named: "editicon")
        editimg = editimg?.resize(size: CGSize(width: 40, height: 40))
//        btn.setTitle("編集", for: .normal)
//        btn.backgroundColor = .blue
//        editAction.image = btn.asImage()
        editAction.image = editimg
        editAction.title = nil
        editAction.backgroundColor = .backgroundColor
//        btn.setTitle("カテゴリ", for: .normal)
//        btn.backgroundColor = .cyan
        var shareimg = UIImage(named: "shareicon")
        shareimg = shareimg?.resize(size: CGSize(width: 40, height: 40))
//        tagAction.image = btn.asImage()
        tagAction.image = shareimg
        tagAction.title = nil
        tagAction.backgroundColor = .backgroundColor

        tableView.isEditing = false

        return [deleteAction,editAction,tagAction]
    }
    
    // option
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    // trueを返すことでCellのアクションを許可しています
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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

//        self.performSegue(withIdentifier: "toZiten", sender: nil)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toZiten") as! ZitenViewController
        secondViewController.group_createTime = self.clicked_group.createTime
        //self.navigationController = UINavigationController(rootViewController: self)
        print(self.navigationController)
        self.navigationController?.pushViewController(secondViewController, animated: true)


    }
    
    // 3D Touch
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
//        viewControllerForLocation location: CGPoint) -> UIViewController? {
//
//        print("3D touched!")
//
////        let locationInTextView = self.view.convert(location, to: textView)
////
////        if let (url, rect) = getInfo(locationInTextView: locationInTextView) {
////            previewingContext.sourceRect = self.view.convert(rect, from: textView)
////            let controller = WebViewController(nibName: nil, bundle: nil)
////            controller.url = url
////            return controller
////        }
//
//        return nil
//    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toZiten" {
            print("toZiten prepare")
            let nextVC = segue.destination as! ZitenViewController
            nextVC.group_createTime = self.clicked_group.createTime
        }
    }


}


//extension ViewController: UIViewControllerPreviewingDelegate {
//    // Peek
//    @available(iOS 10.0, *)
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        guard let indexPath = tableView.indexPathForRow(at: location) else {
//            print("3D TOuch pressed")
//            return nil
//        }
////        return ZitenPreviewViewController(indexPath: indexPath)
////        let clicked = self.groupList[(indexPath as IndexPath).section]
////        return ZitenViewController(group_createTime: clicked.createTime!)
//        return nil
//    }
//
//    // Pop
//    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
//        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
//    }
//}
