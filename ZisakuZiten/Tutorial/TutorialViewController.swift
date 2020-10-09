//
//  TutorialViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/09.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import paper_onboarding

class TutorialViewController: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    let onboarding = PaperOnboarding()
    
    @IBOutlet weak var skipButton:UIButton!

    let items = [
        OnboardingItemInfo(informationImage: UIImage(named: "tutorialImage1")!,
                           title: "シンプル",
                           description: "直感的でわかりやすく、効率よく単語を登録できます",
                           pageIcon: UIImage(named: "tutorialPageImage1")!,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "tutorialImage2")!,
                           title: "自分に合った勉強方法",
                           description: "フラッシュカードやクイズ、音声で再生できます",
                           pageIcon: UIImage(named: "tutorialPageImage2")!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "tutorialImage3")!,
                           title: "共有",
                           description: "知り合いや友達と素早く辞典を共有できます",
                           pageIcon: UIImage(named: "tutorialPageImage3")!,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true
        onboarding.delegate = self
        onboarding.dataSource = self
        setupPaperOnboardingView()

        view.bringSubviewToFront(skipButton)
    }

    func setupPaperOnboardingView() {

        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
            skipButton.isHidden = index == 2 ? false : true
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {

    }
    @IBAction func skipButtonTapped(_: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: Actions
extension ViewController {


}




