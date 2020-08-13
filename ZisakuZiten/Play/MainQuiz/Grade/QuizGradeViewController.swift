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


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = QuizinCorrectCountPageItemViewController()
        vc1.view.tag = 0
        let vc2 = QuizGradePageItemViewController()
        vc2.view.tag = 1
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
        pageControl = UIPageControl(frame: CGRect(x:0, y:self.pageView.frame.height - 25, width:self.pageView.frame.width, height:25))
//        pageControl.backgroundColor = .orange
        
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
            self.progressBarView.value = 55
        }, completion: nil)
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
        let vc2 = QuizGradePageItemViewController()

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
