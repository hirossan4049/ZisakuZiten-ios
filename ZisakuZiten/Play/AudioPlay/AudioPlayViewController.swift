//
//  AudioPlayViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/09/15.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class AudioPlayViewController: PlayBaseViewController, AVSpeechSynthesizerDelegate, UITableViewDelegate, UITableViewDataSource {

    let speechService = SpeechService()
    var play_index:Int!
    var group:Group!
    
    @IBOutlet weak var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechService.synthesizer.delegate = self
        
        play_index = 0
        
        let realm = try! Realm()
        group = realm.objects(Group.self).filter("createTime==%@",createTime!)[0]
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "AudioPlayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
    }
    
    @IBAction func testClick(){
        speechService.say("hoge")
    }
    @IBAction func stop(){
        speechService.stop()
    }


    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didStart utterance: AVSpeechUtterance) {
        // 読み上げスタート
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        // 読み上げ終了
    }


    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        // 読み上げ中の発話
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.group.ziten_upT_List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AudioPlayTableViewCell
        let ziten = self.group.ziten_upT_List[indexPath.section]
        cell.titleLabel.text = ziten.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    

}
