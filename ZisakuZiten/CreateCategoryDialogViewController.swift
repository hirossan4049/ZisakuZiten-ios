//
//  CreateCategoryDialogViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/23.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit

class CreateCategoryDialogViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var CategoryItemHeadView: UIView!
    @IBOutlet weak var CategoryItemBodyView: UIView!
    @IBOutlet weak var CategoryItemTextField: UITextField!

    var selectCategoryColorId: Int = 1
    let categoryColorList: [String] = ["ff7675","55efc4","81ecec","74b9ff","a29bfe","ffeaa7","fd79a8"]

    
    @IBOutlet weak var colorBtn: UIButton!


    private var mySegcon: UISegmentedControl!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        // FIXME:ぼかし入れたいな
        dialogView.layer.cornerRadius = 13
        dialogView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)

        // 解決するまで１億年かかった。
//        scrollView.contentSize = CGSize(width: 500, height: 30)
        scrollView.contentSize = CGSize(width: (50 + 10) * 7, height: 30)


        colorBtn.layer.cornerRadius = 13

    }

    // FIXME: switchで書きたい。
    // thanks https://flatuicolors.com/palette/us
    @IBAction func selectColorBtn(sender: AnyObject){
        let btn:UIButton = sender as! UIButton
        print(btn.tag)

        var hexColor:String!
        selectCategoryColorId = btn.tag
//        switch btn.tag{
//        case 0:
//            hexColor = "ff7675"
//            selectCategoryColorId = 0
//        case 1:
//            hexColor = "55efc4"
//            selectCategoryColorId = 1
//        case 2:
//            hexColor = "81ecec"
//            selectCategoryColorId = 2
//        case 3:
//            //Green Darner tail
//            hexColor = "74b9ff"
//            selectCategoryColorId = 3
//        case 4:
//            //Shy Moment
//            hexColor = "a29bfe"
//            selectCategoryColorId = 4
//        case 5:
//            //sour lemon
//            hexColor = "ffeaa7"
//            selectCategoryColorId = 5
//        case 6:
//            //pico-8 pink
//            hexColor = "fd79a8"
//            selectCategoryColorId = 6
//        default:
//            print("exception")
//        }
        hexColor = categoryColorList[selectCategoryColorId]
        CategoryItemHeadView.backgroundColor = UIColor(hex:hexColor)
        CategoryItemBodyView.backgroundColor = UIColor(hex:hexColor,alpha: 0.2)
    }


    override init(nibName nibNameOrNil: String?, bundle ninBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: ninBundleOrNil)
        self.transitioningDelegate = self
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom

    }

    convenience init(title: String, desc: String) {
        self.init(nibName: "CreateCategoryDialogViewController", bundle: nil)
//        titleText = title
//        messageText = desc
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return AlertAnimation(show:true)
        return nil
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return AlertAnimation(show:false)
        return nil
    }

}

//hex UIColor
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}


//class AlertAnimation : NSObject, UIViewControllerAnimatedTransitioning {
//
//    let show: Bool
//
//    init(show: Bool) {
//        self.show = show
//    }
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        if (show) {
//            return 0.45
//        } else {
//            return 0.25
//        }
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        if (show) {
//            self.presentAnimateTransition(transitionContext: transitionContext)
//        } else {
//            self.dismissAnimateTransition(transitionContext: transitionContext)
//        }
//    }
//
//    func presentAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
//
//        let alertVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! CreateCategoryDialogViewController
//        alertVC.view.frame = UIScreen.main.bounds
//        let containerView = transitionContext.containerView
//        alertVC.alertView.alpha = 0.0
//        alertVC.alertView.center = alertVC.view.center
//        alertVC.alertView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
//        containerView.addSubview(alertVC.view)
//
//        UIView.animate(withDuration: 0.25,
//                       animations: {
//                                    alertVC.view.alpha = 1.0
//                                    alertVC.alertView.alpha = 1.0
//                                    alertVC.alertView.transform = CGAffineTransform.init(scaleX: 1.05, y:1.05)
//        },
//                                   completion: { finished in
//                                    UIView.animate(withDuration:0.2,
//                                                    animations: {
//                                                    alertVC.alertView.transform = CGAffineTransform.identity
//                                    },
//                                                    completion: { finished in
//                                                            if (finished) {
//                                                                    transitionContext.completeTransition(true)
//                                                            }
//                                    })
//        })
//    }
//    func dismissAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
//
//        let alertVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! CreateCategoryDialogViewController
//
//        UIView.animate(withDuration:self.transitionDuration(using: transitionContext),
//                                   animations: {
//                                    alertVC.view.alpha = 0.0
//                                    alertVC.alertView.alpha = 0.0
//                                    alertVC.alertView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
//        },
//                                   completion: { finished in
//                                    transitionContext.completeTransition(true)
//        })
//    }
//}
