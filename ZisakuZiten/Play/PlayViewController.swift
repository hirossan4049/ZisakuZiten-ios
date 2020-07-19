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
    
    var playlists:[Playlist] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PLAY VIEW CONTROLLER")
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "PlaySelectItemTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        playlists.append(Playlist(title: "titlevtyvhjkljhgcfctyctctuycuycytcycytctycyee", detail: "fiegieg"))
        playlists.append(Playlist(title: "title2222", detail: "12345"))
        playlists.append(Playlist(title: "title23334", detail: "faff"))
        playlists.append(Playlist(title: "444", detail: "rtg"))
        playlists.append(Playlist(title: "ti55tleee", detail: "asdfgmjingr"))
        

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
        let playlist = self.playlists[indexPath.row]
        cell.titleLabel.text = playlist.title
        cell.detailLabel.text = playlist.detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(tableView.tag)
//        self.performSegue(withIdentifier: "toQuiz", sender: nil)
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toQuiz") as! QuizViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)


       }
    
    
    
    


}
