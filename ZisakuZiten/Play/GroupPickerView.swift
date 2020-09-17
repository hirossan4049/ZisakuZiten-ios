//
//  GroupPickerView.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/25.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift
import ViewAnimator


class GroupPickerView: UIView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var radiusView:UIView!
    @IBOutlet private weak var tableView:UITableView!
    
    public var selected_Id:Int = 0
    
    private var groupList:Results<Group>!
            



    override init(frame: CGRect) {
       super.init(frame: frame)
//        self.backgroundColor = UIColor.green

   }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        print("GROUP PICKER VIEW : required?")
//        print(testlabel.text)

    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
//        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        print("GROUP PICKERVIEW")
        
        self.backgroundColor = .none
        tableView.backgroundColor = .textFieldBackgroundColor
        
        let realm = try! Realm()
        self.groupList = realm.objects(Group.self)
        
        radiusView.layer.cornerRadius = 15        
        radiusView.layer.borderColor = UIColor(hex: "EBEBEB").cgColor
        radiusView.layer.borderWidth = 1
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        self.tableView.layer.cornerRadius = 15
        
        let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
        UIView.animate(views: tableView.visibleCells, animations: animations, completion: {})

    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.groupList[indexPath.row].title
        cell.backgroundColor = .textFieldBackgroundColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICKED")
        exitPost(createTime: self.groupList[indexPath.row].createTime!)
    }
    
    
    func exitPost(createTime:Date){
//        let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
//        UIView.animate(views: tableView.visibleCells, animations: animations, reversed: true,
//                       initialAlpha: 1.0, finalAlpha: 0.0, completion: {
//                        
//        })
        
        let postArgs:[String: Date] = ["createTime": createTime]
        NotificationCenter.default.post(name: .toExitView,object: nil,userInfo: postArgs)
    }
    


}

extension Notification.Name {
    static let toExitView = Notification.Name("toExitView")
}
