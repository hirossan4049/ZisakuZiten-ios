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
    var play_index:Int = 0
    var group:Group!
    var isselected_lang_Title:Bool!
    
    var titleLang = "en-US"
    var contentLang = "ja-JP"
    
    let langs:[String: String] = ["日本語": "ja-JP", "英語": "en-US","韓国語":"ko-KR","中国語(簡体字)":"zh-cn","中国語(繁体字)":"zh-tw"]
    
    var isFirstLoad = true

    
    var isPlaying = false{
        didSet{
            if isPlaying{
                playButton.setBackgroundImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            }else{
                playButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
        }
    }
    var isPlayedTitle = false
    
    @IBOutlet weak var titleLangLabel:UILabel!
    @IBOutlet weak var contentLangLabel:UILabel!
    
    @IBOutlet weak var progressView:UIProgressView!
    @IBOutlet weak var nowPlayCounterLabel:UILabel!
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var contentLabel:UILabel!
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var playButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechService.synthesizer.delegate = self
        
        play_index = 0
        
        let realm = try! Realm()
        group = realm.objects(Group.self).filter("createTime==%@",createTime!)[0]
        
        isFirstLoad = false
        
        self.view.backgroundColor = .backgroundColor
        tableView.backgroundColor = .backgroundColor
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "AudioPlayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.reloadData()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.pickerExitCall(_:)),
                                               name: Notification.Name("toExitPickerPopup"),
                                               object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isFirstLoad{
            play_index = 0

            let realm = try! Realm()
            group = realm.objects(Group.self).filter("createTime==%@",createTime!)[0]
            tableView.reloadData()
        }
    }
    
    
    @IBAction func start(){
//        speechService.say("hoge")
        if isPlaying{
            //stop
            isPlaying = false
            speechService.stop()
        }else{
            speechService.voice = AVSpeechSynthesisVoice(language: titleLang)
            speechService.say(group.ziten_upT_List[play_index].title!)
            isPlayedTitle = true
            isPlaying = true
        }
        tableView.reloadData()
        print(isPlaying)
    }
    func stop(){
        speechService.stop()
    }
    
    @IBAction func titleLangPopup(){
        isselected_lang_Title = true
        openLangSelectPopup()

    }
    @IBAction func contentLangPopup(){
        isselected_lang_Title = false
        openLangSelectPopup()
    }
    
    @IBAction func exit(){
        stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    func openLangSelectPopup(){
        let pickerVC = PickerPopupViewController()
        pickerVC.modalTransitionStyle = .crossDissolve
        pickerVC.modalPresentationStyle = .formSheet
//        pickerVC.pickerNavigationItem.title = "言語を選択"
        pickerVC.dataList = [String](langs.keys)
//        pickerVC.backView.layer.cornerRadius = 10
//        pickerVC.view.backgroundColor = UIColor(hex: "000000",alpha: 0.3)

//        alertView.modalPresentationStyle = .fullScreen
        present(pickerVC, animated: true, completion: nil)
        print("CreateCatPress")
    }
    
    @objc func pickerExitCall(_ notification: NSNotification){
        print("Exit called!!")
        let selected:String = notification.userInfo!["selected"]! as! String
        print(langs[selected])
        //fixme Button name
        if isselected_lang_Title{
            titleLang = langs[selected]!
            titleLangLabel.text = selected
        }else{
            contentLang = langs[selected]!
            contentLangLabel.text = selected
        }
    }



    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didStart utterance: AVSpeechUtterance) {
        // 読み上げスタート
        if play_index < group.ziten_upT_List.count{
            titleLabel.text = group.ziten_upT_List[play_index].title
            contentLabel.text = group.ziten_upT_List[play_index].content

            
    //        print((play_index+1) / group.ziten_upT_List.count)
            progressView.setProgress(Float(Double(play_index+1) / Double(group.ziten_upT_List.count)), animated: true)
            nowPlayCounterLabel.text = "\(play_index + 1)/\(group.ziten_upT_List.count)"
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        // 読み上げ終了
        if !isPlaying{
            return
        }
        if play_index >= group.ziten_upT_List.count{
            print("END PLAY")
            isPlaying = false
            play_index = 0
        }else{
            
            if isPlayedTitle{
                speechService.voice = AVSpeechSynthesisVoice(language: contentLang)
                speechService.say(group.ziten_upT_List[play_index].content!)
                isPlayedTitle = false
                play_index += 1
                print("contents playing")
            }else{
                speechService.voice = AVSpeechSynthesisVoice(language: titleLang)
                speechService.say(group.ziten_upT_List[play_index].title!)
                isPlayedTitle = true
                print("title plating")
                
            }
        }
        tableView.reloadData()
    }


    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        // 読み上げ中の発話
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8 // space size
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.group.ziten_upT_List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AudioPlayTableViewCell
        let ziten = self.group.ziten_upT_List[indexPath.section]
        cell.titleLabel.text = ziten.title
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        cell.index = indexPath.section
        cell.selectionStyle = .none
        cell.playButton.tag = indexPath.section
        cell.playButton.addTarget(self, action: #selector(tapCellButton(_:)), for: .touchUpInside)
        if isPlaying{
            cell.isPlaying = indexPath.section == play_index
        }else{
            cell.isPlaying = false
        }
        return cell
    }
    
    //FIXME:PlayButton change icon
    @objc func tapCellButton(_ sender: UIButton){
        
        if isPlaying{
            if play_index == sender.tag{
                // stop
                
                play_index = sender.tag
                speechService.stop()
                isPlaying = false
                tableView.reloadData()
                return
            }
        }
        play_index = sender.tag
        tableView.reloadData()
        speechService.stop()
        speechService.voice = AVSpeechSynthesisVoice(language: titleLang)
        speechService.say(group.ziten_upT_List[play_index].title!)
        self.isPlayedTitle = true
        isPlaying = true
        
//        if play_index == sender.tag{
//            // stop
//
//            play_index = sender.tag
//            speechService.stop()
//        }else{
//            play_index = sender.tag
//            tableView.reloadData()
//            speechService.stop()
//            speechService.say(group.ziten_upT_List[play_index].title!)
//            self.isPlayedTitle = true
//            isPlaying = true
//
//
//        }
    }
    
    

}
