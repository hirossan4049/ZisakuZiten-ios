//
//  TutorialViewController.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/09.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit
import paper_onboarding

class TutorialViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()

      let onboarding = PaperOnboarding()
      onboarding.dataSource = self
      onboarding.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(onboarding)

      // add constraints
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
}
