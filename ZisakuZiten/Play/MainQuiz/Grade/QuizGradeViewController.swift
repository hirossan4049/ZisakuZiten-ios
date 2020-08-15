//
//  QuizGradeViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/08/07.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class QuizGradeViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    @IBOutlet weak var progressBarView: MBCircularProgressBarView!
    @IBOutlet weak var pageView:UIView!
    var pageViewController:UIPageViewController!
    var viewControllersArray:Array<UIViewController> = []
    var pageControl: UIPageControl!

    var finished_list:[Ziten]! = []
    var finished_isCorrectList:[Bool] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 正解したやつとかここで処理するとグッチャグチャになりそうだから向こうでやる。これぐらいならメモリ大丈夫やろ（軽視
        let vc1 = QuizinCorrectCountPageItemViewController()
        vc1.view.tag = 0
        vc1.finished_isCorrectList = self.finished_isCorrectList
        vc1.finished_list = self.finished_list
        let vc2 = QuizGradePageItemViewController()
        vc2.view.tag = 1
        vc2.finished_isCorrectList = self.finished_isCorrectList
        vc2.finished_list = self.finished_list
        viewControllersArray.append(vc1)
        viewControllersArray.append(vc2)
        
        pageView.layer.cornerRadius = 13
        
        pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll,
                                                  navigationOrientation: UIPageViewController.NavigationOrientation.horizontal,
                                                  options: nil)
        //DelegateとDataSouceの設定
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let view = UIView()
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor
//        vc.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        //はじめに生成するページを設定
        pageViewController.setViewControllers([vc1], direction: .forward, animated: true, completion: nil)
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.pageView.frame.width, height: self.pageView.frame.height)
        self.pageView.addSubview(pageViewController.view!)
        
        //PageControlの生成
        pageControl = UIPageControl(frame: CGRect(x:0, y:self.pageView.frame.height, width:self.pageView.frame.width, height:100))
        pageControl.backgroundColor = .orange
        
        // PageControlするページ数を設定する.
        pageControl.numberOfPages = 2
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        
        // 現在ページを設定する.
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        self.pageView.addSubview(pageControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .allowAnimatedContent, animations: {
            let nms:Double = self.getCorrectCount() / 30 * 100
            let correctrate = round(nms)
            print("CORRECT COUNT",self.getCorrectCount(),  correctrate)
            self.progressBarView.value = CGFloat(correctrate)
        }, completion: nil)
    }
    
    func getCorrectCount() -> Double{
        var count = 0
        for i in self.finished_isCorrectList{
            if i{
                count += 1
            }
        }
        return Double(count)
    }
    
    
    @IBAction func exit_onPress(){
        exit()
    }
    func exit(){
        guard let secondVc = self.presentingViewController as? QuizViewController else {return}
        secondVc.dismiss(animated: false, completion: nil)
        secondVc.display_discard()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    


    //指定されたViewControllerの前にViewControllerを返す
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag
        pageControl.currentPage = index
        if index == 1{
            return nil
        }
        index = index + 1
//        let view = UIView()
//        let vc = UIViewController()
//        vc.view.backgroundColor = UIColor.randomColor
//        vc.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        return viewControllersArray[index]
    }
    
    //DataSourceのメソッド
    //指定されたViewControllerの前にViewControllerを返す
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = viewController.view.tag
        print(index)
        pageControl.currentPage = index
        index = index - 1
        if index < 0{
            return nil
        }
//        let vc = UIViewController()
//        vc.view.backgroundColor = UIColor.randomColor
//
//        let vc2 = QuizGradePageItemViewController()
//        vc.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return viewControllersArray[index]
    }
    
    //Viewが変更されると呼ばれる
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        print("moved")
    }

}
