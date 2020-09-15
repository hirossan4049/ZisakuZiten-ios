//
//  SelectCategoryViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/18.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import RealmSwift

class SelectCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet weak var toolbar:UIToolbar!
    @IBOutlet weak var navigationBar:UINavigationBar!
    
    @IBOutlet weak var fragmentView:UIView!
    weak var currentViewController: UIViewController!
    @IBOutlet var selectViewController:UIViewController!
    @IBOutlet var createViewController:UIViewController!
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var tableView:UITableView!
    var selected_index:Int!
    var categorys:Results<Category>!

    @IBOutlet weak var colorStackView:UIStackView!
    @IBOutlet weak var createTextField:UITextField!
    


    var createCategorySelectedColor:UIColor!
    
    var isCreatemode = true

    /// tag 1~2 CATEGORY COLOR ONLY. DO NOT USE.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        categorys = realm.objects(Category.self)
        
        self.view.backgroundColor = .backgroundColor
        navigationBar.backgroundColor = .backgroundColor
        navigationBar.barTintColor = .backgroundColor
//        navigationBar.layer.borderWidth = 0.3
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(createTextFieldDidEndEditing(notification:)), name: UITextField.textDidChangeNotification, object: createTextField)
        
        doneBarButtonItem.isEnabled = false
        
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
        print("DONE")
        if isCreatemode{
            //create
            print("CREATE")
            let category = Category()
            category.createTime = Date()
            category.title = createTextField.text
            category.colorCode = createCategorySelectedColor.toHexString()
            let realm = try! Realm()
            try! realm.write({
                realm.add(category)
            })
            createTextField.text = ""
            changeFragments(.select)
        }else{
            let createTime = categorys[selected_index].createTime!
            let postArgs:[String: Date] = ["createTime": createTime]
            NotificationCenter.default.post(name: SelectCategoryViewController.selectedNotification ,object: nil,userInfo: postArgs)
            self.dismiss(animated: true, completion: nil)
        }
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
    
    @objc func createTextFieldDidEndEditing(notification:NSNotification) {
        let textField = notification.object as! UITextField
        if textField.text == "" {
            doneBarButtonItem.isEnabled = false
        } else {
            doneBarButtonItem.isEnabled = true
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
            if selected_index == nil{
                doneBarButtonItem.isEnabled = false

            }else{
                doneBarButtonItem.isEnabled = true
                tableView.selectRow(at: IndexPath(row: 1, section: selected_index), animated: false, scrollPosition: .bottom)
            }
            tableView.reloadData()
        case 1:
            // create
//        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ComponentCreate")
            self.currentViewController = self.createViewController
            self.isCreatemode = true
            createTextField.becomeFirstResponder()
            doneBarButtonItem.isEnabled = false
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
        return self.categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectCategoryTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.titleLabel.text = self.categorys[indexPath.section].title
        cell.categoryColor = self.categorys[indexPath.section].colorCode ?? "ffffff"
        print(self.categorys[indexPath.section].colorCode)
        cell.categoryColorView.backgroundColor = UIColor(hex: cell.categoryColor)
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        self.doneBarButtonItem.isEnabled = true
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

extension SelectCategoryViewController{
    static let selectedNotification = Notification.Name("selectedNotification")
}
