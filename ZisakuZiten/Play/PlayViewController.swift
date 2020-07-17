//
//  PlayViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/15.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PLAY VIEW CONTROLLER")
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "PlaySelectItemTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaySelectItemTableViewCell
        return cell
    }
    
    
    


}
