//
//  TabBarController.swift
//  E-Mistri
//
//  Created by gurzu on 13/01/2023.
//

import UIKit
import SwipeableTabBarController

class TabBarController: SwipeableTabBarController {
    
    static let identifier: String = "TabBarController"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 20.0
        tabBar.backgroundColor = .white
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.shadowColor = UIColor.commonShadow.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -8)
        tabBar.layer.shadowOpacity = 0.3
    }
}
