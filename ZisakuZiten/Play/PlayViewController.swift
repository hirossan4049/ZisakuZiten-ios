//
//  PlayViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/07/15.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import ViewAnimator


class PlayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var tableView: UITableView!
    
//    var playlists:[Playlist] = []
    var playlists:[PlayListItem] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "学ぶ"
        self.navigationController?.title = ""
        print("PLAY VIEW CONTROLLER")
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .backgroundColor
        
        let nib = UINib(nibName: "PlaySelectItemTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .backgroundColor
        
        self.navigationController?.navigationBar.barTintColor = .navigationBarColor
        
        self.tableView.separatorStyle = .none

        
        self.playlists = Playlist().getAllItems()
        
        // memory ok...?
//        playlists.append(Playlist(title: "FlashCard", detail: "単語と意味が交互に表示されます。"))
//        playlists.append(Playlist(title: "Quiz", detail: "苦手な単語を中心的にクイズできます。"))
//        playlists.append(Playlist(title: "音声で再生", detail: "単語と意味を読み上げてくれます。"))
//        playlists.append(Playlist(title: "444", detail: "rtg"))

        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
//        UIView.animate(views: tableView.visibleCells, animations: animations, completion: {})
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
        UIView.animate(views: tableView.visibleCells, animations: animations, completion: {})
        
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
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.tag = indexPath.row
        let playlist = self.playlists[indexPath.section]
        cell.titleLabel.text = playlist.title
        cell.detailLabel.text = playlist.subtitle
        cell.plyimageView1.image = UIImage(named: playlist.image1)
        cell.plyimageView2.image = UIImage(named: playlist.image2)
        cell.plyimageView3.image = UIImage(named: playlist.image3)
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
        self.navigationController?.pushViewController(secondViewController, animated: true)


       }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlaySelectItemTableViewCell
        print("didHightlightRowAt")
//        cell.bodyView.backgroundColor = .lightGray
//        cell.translatesAutoresizingMaskIntoConstraints = true
//        UIView.animate(withDuration: 0.1 , delay: 0, animations: {
//            cell.bodyView.frame.size = CGSize(width: 30, height: 30)
//        })
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlaySelectItemTableViewCell
        cell.bodyView.backgroundColor = .playCellBackgroundColor
//        UIView.animate(withDuration: 0.1 , delay: 0, animations: {
//            cell.bodyView.frame.size = CGSize(width: 100, height: 100)
//        })
//        cell?.backgroundView
        
    }
    
    // 背景透けるように
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    
    


}
