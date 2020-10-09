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
import Log
import AMScrollingNavbar
import LSDialogViewController


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate, UIViewControllerPreviewingDelegate, ScrollingNavigationControllerDelegate {

    let cellReuseIdentifier = "cell"
    var groupList: Results<Group>!
    var clicked_group: Group!
    @IBOutlet var tableView: UITableView!
    @IBOutlet private weak var createBtn:UIButton!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var importBtn:UIBarButtonItem!
    
    var dController :UIDocumentInteractionController!
    var isBegin = true
    var log:Logger!

    

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
        
        importBtn.image = importBtn.image!.resize(size:CGSize(width: 20, height: 20))

        let realm = try! Realm()
        self.groupList = realm.objects(Group.self)
        
        self.log = Logger()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.barTintColor = .navigationBarColor
        self.tableView.separatorStyle = .none

        
        self.tabBarItem.title = nil
            
        // 3D Touchが使える端末か確認
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.cell_animation()
        }
    }
    
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
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
    
    
    @IBAction func importGroupOpen(){
        let vc = GroupShareImportViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.definesPresentationContext = false
        presentDialogViewController(vc, animationPattern: .fadeInOut)
    
    }

    @IBAction func openhelp(){
        let url = URL(string: "https://github.com/hirossan4049/ZisakuZiten-ios/blob/master/README.md")
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.openURL(url!)
        }
    }

    @IBAction func createGroup_on_press() {
        ///FIXME: category
//        createGroupDialog()
        UIView.animate(withDuration: 0.1 , delay: 0, animations: {
            self.createBtn.frame.size = CGSize(width: 60, height: 60)
            self.createBtn.frame.origin.x -= 2.5
            self.createBtn.frame.origin.y -= 2.5
        })
        createGroupDialog_new()
    }
    
    @IBAction func createGroupTouchUp(_ sender: Any) {
        print("on touch up")
        UIView.animate(withDuration: 0.1 , delay: 0, animations: {
            self.createBtn.frame.size = CGSize(width: 60, height: 60)
            self.createBtn.frame.origin.x -= 2.5
            self.createBtn.frame.origin.y -= 2.5
        })
    }
    
    @IBAction func createGroupOnTouchDown(_ sender: Any) {
        print("on touch down")
        createBtn.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: 0.1 , delay: 0, animations: {
            self.createBtn.frame.size = CGSize(width: 55, height: 55)
            self.createBtn.frame.origin.x += 2.5
            self.createBtn.frame.origin.y += 2.5
            
        })
    }
    
    
    
    @IBAction func createCategory_on_press(){
        self.performSegue(withIdentifier: "toCategoryEdit", sender: nil)
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
//        let alertView = CreateGroupViewController()
//        alertView.modalTransitionStyle = .crossDissolve
//        alertView.modalPresentationStyle = .overCurrentContext
//        present(alertView, animated: true, completion: nil)
//        print("CreateCatPress")
        
        let vc = CreateGroupViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.definesPresentationContext = false
        presentDialogViewController(vc, animationPattern: .fadeInOut)
    
    }
    

    func dismissDialog() {
        dismissDialogViewController(LSAnimationPattern.fadeInOut)
        tableView.reloadData()
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
                        self.tableView.reloadData()
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
        alertView.delegate = self
        alertView.modalTransitionStyle = .crossDissolve
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.createTime = createTime
        alertView.EDIT_MODE = true
        presentDialogViewController(alertView, animationPattern: .fadeInOut)
        
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
        self.present(dialog, animated: true, completion: nil)
    }
    
    func group2json(group:Group) -> String{
        var zitenList:[[String:Any]] = []
        var groupDict:[String:Any] = [:]
        groupDict["title"] = group.title
        groupDict["createTime"] = group.createTime?.toString()
        groupDict["updateTime"] = group.updateTime?.toString()
        for ziten in group.ziten_upT_List{
            var zitenDict:[String:Any] = [:]
            zitenDict["title"] = ziten.title
            zitenDict["content"] = ziten.content
            zitenDict["createTime"] = ziten.createTime?.toString()
            zitenDict["updateTime"] = ziten.updateTime?.toString()
            zitenList.append(zitenDict)
        }
        groupDict["ziten_updT_List"] = zitenList
        
        let jsonData = try! JSONSerialization.data(withJSONObject: groupDict, options: [])
        let jsonStr = String(bytes: jsonData, encoding: .utf8)!

        return jsonStr
    }
    
    func jsonDict2Group(title:String,createTime:Date,updateTime:Date,ziten_dict:[NSDictionary]){
        let realm = try! Realm()
        let group = Group()
        log.debug("THIS IS JSON DICT 2 GROUP!")
        group.title = title
        group.createTime = createTime
        group.updateTime = updateTime
        
        for item in ziten_dict{
            let ziten = Ziten()
            ziten.title = item["title"] as! String
            ziten.content = item["content"] as! String
            ziten.createTime = (item["createTime"] as! String).toDate()
            ziten.updateTime = (item["updateTime"] as! String).toDate()

            group.ziten_upT_List.append(ziten)
        }
        
        print(group)
        try! realm.write({
            realm.add(group)
        })
        tableView.reloadData()
        log.debug("json2Group imported!")
                
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
    
    func simpleDialog(title:String, message: String){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
//        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
//            (action: UIAlertAction!) -> Void in
//            print("Cancel")
//        })

//        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
    }
    
    func openDialogJsonORUrl(data:Group){
        let dialog = UIAlertController(title: "共有する", message: "どの方法で共有しますか？", preferredStyle: .actionSheet)
        dialog.addAction(UIAlertAction(title: "jsonで保存して共有", style: .default, handler: {
            (action:UIAlertAction!) -> Void in self.jsonShare(data: data)}))
        dialog.addAction(UIAlertAction(title: "シェアコードを作成して共有", style: .default, handler: {
            (action:UIAlertAction!) -> Void in self.urlShare(data: data)}))
        
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    
    func jsonShare(data:Group){
        startIndicator()
        let jsondata = self.group2json(group: data)
        let filename = data.title! + ".json"
        self.saveFile(filename: filename, data: jsondata)
        self.dismissIndicator()
    }
    func urlShare(data:Group){
        let jsondata = self.group2json(group: data)
        let api = ShareAPI()
        self.startIndicator()

        DispatchQueue.global(qos: .default).async {
            api.post(params: jsondata, result: {(res: ShareAPI.Result,id: String,passwd: String) in
                DispatchQueue.main.async {
                    self.dismissIndicator()

                }
                print(res)
                if res == .ng{
                    DispatchQueue.main.async {
                        self.simpleDialog(title: "送信失敗", message: "サーバーに送信できませんでした。もう一度試してください。インターネットが接続されていないかサーバー側で不具合がある可能性があります。")
                    }
                }else if res == .ok{
                    DispatchQueue.main.async {
//                        self.simpleDialog(title: "送信成功", message: id)
                        let vc = GroupShareURLViewController()
                        vc.modalPresentationStyle = .overFullScreen
                        vc.delegate = self
                        self.navigationController?.definesPresentationContext = false
                        self.presentDialogViewController(vc, animationPattern: .fadeInOut)
                        vc.modalPresentationStyle = .overFullScreen
                        vc.codeLabel.text = id
                        vc.deleteLabel.text = passwd
                    }
                }else{
                    self.simpleDialog(title: "送信失敗", message: "サーバーに送信できませんでした。もう一度試してください。インターネットが接続されていないかサーバー側で不具合がある可能性があります。")
                }
                })
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

        let group: Group = self.groupList[(indexPath as IndexPath).section]

        cell.titleLabel.text = group.title
        cell.dateLabel.text = group.createTime?.toStringJapanese()
        cell.dateLabel.textColor = .baseTextColor
        let realm = try! Realm()
        let categorys = realm.objects(Category.self).filter("createTime==%@",group.category)
        if categorys.isEmpty{
            cell.categoryView.isHidden = true
        }else{
            cell.categoryView.isHidden = false
            cell.categoryView.categoryColorView.tintColor = UIColor(hex:categorys[0].colorCode ?? "fffffff")
            cell.categoryView.mainLabel.text = categorys[0].title
        }
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


//    
    // CELL EDIT
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        print(indexPath)
        let group = self.groupList[(indexPath as IndexPath).section]
    
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in 
            action.fulfill(with: .reset)
            self.deleteGroup(id: (indexPath as IndexPath).section)
            print("DELETE")
        }
        let editAction = SwipeAction(style: .destructive, title: "Edit") { action, indexPath in
            self.editGroupDialog(createTime: group.createTime!)
        }
        /// FIXME:group2json loading.
        let tagAction = SwipeAction(style: .destructive, title: "share") { action, indexPath in
            print("group2json start")
            self.openDialogJsonORUrl(data: group)

        }

        deleteAction.transitionDelegate = ScaleTransition.default
        
        var deleteimg = UIImage(named: "deleteicon")
        deleteimg = deleteimg?.resize(size: CGSize(width: 40, height: 40))
        deleteAction.image = deleteimg
        deleteAction.title = nil
        deleteAction.backgroundColor = .backgroundColor

        var editimg = UIImage(named: "editicon")
        editimg = editimg?.resize(size: CGSize(width: 40, height: 40))
        editAction.image = editimg
        editAction.title = nil
        editAction.backgroundColor = .backgroundColor

        var shareimg = UIImage(named: "shareicon")
        shareimg = shareimg?.resize(size: CGSize(width: 40, height: 40))
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toZiten") as! ZitenViewController
        secondViewController.group_createTime = self.clicked_group.createTime
        self.navigationController?.pushViewController(secondViewController, animated: true)


    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toZiten" {
            let nextVC = segue.destination as! ZitenViewController
            nextVC.group_createTime = self.clicked_group.createTime
        }
    }
    
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
        }
        

}
