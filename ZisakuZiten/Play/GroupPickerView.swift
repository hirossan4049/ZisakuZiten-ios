//
//  GroupPickerView.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/25.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit


class GroupPickerView: UIView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var radiusView:UIView!
    @IBOutlet private weak var tableView:UITableView!
        



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
        radiusView.layer.cornerRadius = 15
        print(radiusView.subviews)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        


    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "hello"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICKED")
        exitPost()
    }
    
    
    func exitPost(){
        NotificationCenter.default.post(name: .toExitView,object: nil)
    }
    


}

extension Notification.Name {
    static let toExitView = Notification.Name("toExitView")
}
