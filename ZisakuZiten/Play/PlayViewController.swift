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
    
//    var playlists:[Playlist] = []
    var playlists:[PlayListItem] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PLAY VIEW CONTROLLER")
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "PlaySelectItemTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        self.playlists = Playlist().getAllItems()
        
        // memory ok...?
//        playlists.append(Playlist(title: "FlashCard", detail: "単語と意味が交互に表示されます。"))
//        playlists.append(Playlist(title: "Quiz", detail: "苦手な単語を中心的にクイズできます。"))
//        playlists.append(Playlist(title: "音声で再生", detail: "単語と意味を読み上げてくれます。"))
//        playlists.append(Playlist(title: "444", detail: "rtg"))

        

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.playlists.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // spacing 間隔
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaySelectItemTableViewCell
        cell.tag = indexPath.row
        let playlist = self.playlists[indexPath.section]
        cell.titleLabel.text = playlist.title
//        cell.detailLabel.text = playlist.detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(tableView.tag)
//        self.performSegue(withIdentifier: "toQuiz", sender: nil)
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toQuiz") as! QuizNavigationController
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toQuiz") as! PlayStartViewController
        secondViewController.playItem = self.playlists[indexPath.section]
        //self.navigationController = UINavigationController(rootViewController: self)
        print(self.navigationController)
        self.navigationController?.pushViewController(secondViewController, animated: true)


       }
    
    // 背景透けるように
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    
    


}
