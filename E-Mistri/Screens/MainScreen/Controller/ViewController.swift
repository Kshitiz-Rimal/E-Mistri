//
//  ViewController.swift
//  E-Mistri
//
//  Created by gurzu on 26/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let userData: UserData = Storage.shared.load(key: Text.userKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if KeyChain.getKeyChain() == "" && !userData.userIsActive {
            toLoginScreen()
        } else if userData.userIsActive {
            toDashboardScreen()
        } else {
            toOnboardingScreenScreen()
        }
    }
    
    private func toOnboardingScreenScreen() {
        let onBoardingScreenStoryboard = UIStoryboard(name: Storyboards.OnBoardingScreens, bundle: nil)
        if let viewController = onBoardingScreenStoryboard.instantiateViewController(
            withIdentifier: FirstOnBoardingScreenViewController.identifier) as? FirstOnBoardingScreenViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func toLoginScreen() {
        let loginScreenStoryboard = UIStoryboard(name: Storyboards.LoginAndSignupScreen, bundle: nil)
        if let viewController = loginScreenStoryboard.instantiateViewController(
            withIdentifier: LoginScreenTableViewController.identifier) as? LoginScreenTableViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func toDashboardScreen() {
        let dashboardScreenStoryboard = UIStoryboard(name: Storyboards.DashboardScreen, bundle: nil)
        guard let viewController = dashboardScreenStoryboard.instantiateViewController(
            withIdentifier: TabBarController.identifier) as? TabBarController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
