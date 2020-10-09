//
//  GroupShareImportCheckViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/08.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class GroupShareImportCheckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data: String!
    private var group:Group!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var navigationbar:UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationbar.barTintColor = .backgroundColor
        tableView.backgroundColor = .backgroundColor
        self.tableView.separatorStyle = .none

        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "ZitenTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        json2group()
    }
    
    func json2group(){
        do{
            let jsonArray = try JSONSerialization.jsonObject(with: self.data.data(using: .utf8)!, options: []) as! NSDictionary

            let tesst = jsonArray["ziten_updT_List"] as! NSArray
            let gdata = tesst.map{$0 as! NSDictionary}
            
            let updateTime = (jsonArray["updateTime"] as! String).toDate()
                        
            jsonDict2Group(title: jsonArray["title"] as! String, updateTime: updateTime, ziten_dict: gdata)

        }catch{
            print("ERROR\(error)")
        }
        
    }
    
    func jsonDict2Group(title:String,updateTime:Date,ziten_dict:[NSDictionary]){
        let group = Group()
        group.title = title
        group.createTime = updateTime
        group.updateTime = updateTime
        
        for item in ziten_dict{
            let ziten = Ziten()
            ziten.title = item["title"] as! String
            ziten.content = item["content"] as! String
            ziten.createTime = (item["updateTime"] as! String).toDate()
            ziten.updateTime = (item["updateTime"] as! String).toDate()

            group.ziten_upT_List.append(ziten)
        }
        self.group = group
//        try! realm.write({
//            realm.add(group)
//        })
    }
    
    @IBAction func append(){
        let realm = try! Realm()
        try! realm.write({
            realm.add(self.group)
        })
        self.dismiss(animated: true, completion: nil)
        (self.presentingViewController as! GroupShareImportViewController).exit()

    }
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
        (self.presentingViewController as! GroupShareImportViewController).exit()
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.group.ziten_upT_List.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZitenTableViewCell
        cell.titleLabel.text = self.group.ziten_upT_List[indexPath.row].title
        cell.contentLabel.text = self.group.ziten_upT_List[indexPath.row].content
        return cell
    }





}
