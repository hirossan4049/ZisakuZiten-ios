//
//  SelectCategoryViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/18.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class SelectCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet weak var toolbar:UIToolbar!
    @IBOutlet weak var navigationBar:UINavigationBar!
    
    @IBOutlet weak var fragmentView:UIView!
    weak var currentViewController: UIViewController!
    @IBOutlet var selectViewController:UIViewController!
    @IBOutlet var createViewController:UIViewController!
    
    @IBOutlet weak var colorStackView:UIStackView!
    
    @IBOutlet weak var tableView:UITableView!
    
    var selected_index:Int!


    var createCategorySelectedColor:UIColor!
    
    var isCreatemode = true

    /// tag 1~2 CATEGORY COLOR ONLY. DO NOT USE.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        navigationBar.backgroundColor = .backgroundColor
        navigationBar.barTintColor = .backgroundColor
        navigationBar.layer.borderWidth = 0.3
        
        tableView.backgroundColor = .backgroundColor
        let nib = UINib(nibName: "SelectCategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
//        toolbar.backgroundColor = .backgroundColor
//        toolbar.barTintColor = .backgroundColor
//        toolbar.tintColor = .white
//        toolbar.layer.borderWidth = 0.3
//        toolbar.layer.borderColor = UIColor.darkGray.cgColor
        // Do any additional setup after loading the view.
        print("VCs",selectViewController,createViewController)
        changeFragments(.select)
        print("currentVC",currentViewController)
        
        colorStackView.axis = .horizontal
        colorStackView.alignment = .center
//        colorStackView.distribution = .fill
//        colorStackView.spacing = 20
        
//        let switchh = UISwitch()
//        switchh.isOn = true
//        switchh.backgroundColor = UIColor.cyan
//        colorStackView.addArrangedSubview(switchh)

        

    }
    

    enum FragmentsViewType{

        case select
        case create

        func id() -> Int{
            switch self {
            case .select:
                return 0
            case .create:
                return 1
            }
        }
    }
    
    @IBAction func testclicked(){
        print("CLICKED!")
        changeFragments(.create)
    }
    @IBAction func testseni(){
        print("CLICKED")
        changeFragments(.select)
    }
    @IBAction func clicked(){
        print("CLICKED")
    }
    
    @IBAction func cancel(){
        if isCreatemode{
            changeFragments(.select)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func done(){
        
    }
    
    @IBAction func categoryColor(sender: UIButton){
        self.createCategorySelectedColor = sender.tintColor
        switch sender.tag{
        case 1:
            let button: UIButton = self.view.viewWithTag(2) as! UIButton
            button.tag = 1
            button.setBackgroundImage(UIImage(systemName:"circle.fill"), for: .normal)
            sender.tag = 2
            sender.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        case 2:
            break
        default:
            break
        }
    }
    
    func changeFragments(_ type:FragmentsViewType){
        let id = type.id()
        print(id)
        switch id{
        case 0:
            // select
//            self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ComponentSelect")
            self.currentViewController = self.selectViewController
            self.isCreatemode = false
        case 1:
            // create
//        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ComponentCreate")
            self.currentViewController = self.createViewController
            self.isCreatemode = true
        default: break
            
        }

//        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
//        self.addChild(self.currentViewController!)

        currentViewController!.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.fragmentView.frame.height)
        currentViewController!.view.backgroundColor = .backgroundColor
        // remove framgment view
        let subviews = self.fragmentView.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        self.fragmentView.addSubview(currentViewController.view)

       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectCategoryTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.categoryColor = "ffffff"
        cell.categoryColorView.backgroundColor = UIColor(hex: cell.categoryColor)
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        self.selected_index = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectCategoryTableViewCell
        cell.backgroundColor = UIColor(hex: cell.categoryColor,alpha: 0.4)
//        tableView.deselectRow(at: indexPath, animated: true)
        
   }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8 // space size
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }




}
