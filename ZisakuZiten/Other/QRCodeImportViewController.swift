//
//  QRCodeImportViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/11.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import MercariQRScanner

class QRCodeImportViewController: UIViewController, QRScannerViewDelegate, UIAdaptivePresentationControllerDelegate {
    var delegate: ViewController?
    private var qrScannerView:QRScannerView!
    @IBOutlet weak var qrcodeReaderView:UIView!
    
    private var isOpenChecker = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        qrScannerView = QRScannerView(frame: view.bounds)
        qrcodeReaderView.addSubview(qrScannerView)
        qrScannerView.configure(delegate: self)
        qrScannerView.startRunning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
        if isOpenChecker{
            delegate?.dismissDialog()
            self.dismiss(animated: true)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }

    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: true, completion: completion)
        qrScannerView.stopRunning()
    }


    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
        self.errorDialog()
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        print(code)
        let api = ShareAPI()
        if !code.contains(api.baseurl + "/share/"){
            self.errorDialog()
            return
        }
        let id = code.replacingOccurrences(of: api.baseurl + "/share/", with: "")
        print(id)
        self.startIndicator()
        api.get(id: id, result: {(res: ShareAPI.Result, data: String) in
            if res == .ok{
                DispatchQueue.main.sync {
                    self.dismissIndicator()
                    self.checkOpen(data:data)
                }
            }else{
                if Thread.isMainThread{
                    self.errorDialog()
                    DispatchQueue.main.sync {
                         self.dismissIndicator()
                     }
                }else{
                    DispatchQueue.main.sync {
                        self.errorDialog()
                        self.dismissIndicator()
                    }
                }}})
    }
    
    func checkOpen(data:String){
        self.isOpenChecker = true
        let alertView = GroupShareImportCheckViewController()
        alertView.data = data
        alertView.presentationController?.delegate = self
        self.present(alertView, animated: true, completion: nil)
    }
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if isOpenChecker{
            self.dismiss(animated: true)
            self.delegate?.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.delegate?.cell_animation()
            }
        }
    }
    
    
    func errorDialog(){
        let alert: UIAlertController = UIAlertController(title: "取得失敗", message: "辞典の取得に失敗しました。コードが間違っているか、インターネットに接続されていないか、サーバー側に問題があります。", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.qrScannerView.startRunning()
            self.qrScannerView.rescan()
        })
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func exit(){
        self.dismiss(animated: true, completion: nil)
    }

}
 
