//
//  ThirdOnBoardingScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 29/12/2022.
//

import UIKit

class ThirdOnBoardingScreenViewController: UIViewController {
    
    @IBOutlet weak var curvedBottomImage: UIImageView!
    @IBOutlet weak var gettingStartedImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    @IBOutlet weak var goNextButton: RoundedButton!
    
    static let identifier: String = "ThirdOnBoardingScreenViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(skipTapped))
    }
    
    func viewComponents() {
        curvedBottomImage.image = UIImage(named: Images.CurvedBottomImage)
        gettingStartedImage.image = UIImage(named: Images.GettingStarted)
        titleText.numberOfLines = 2
        titleText.textAlignment = .center
        titleText.text = Text.titleTextThirdOnboardingScreen
        titleText.font = .boldSystemFont(ofSize: FontSize.titleFontSize)
        bodyText.numberOfLines = 0
        bodyText.textAlignment = .center
        bodyText.text = Text.bodyTextThirdOnboardingScreen
        if let imageView = goNextButton.imageView {
            goNextButton.bringSubviewToFront(imageView)
        }
        goNextButton.addTarget(self, action: #selector(goNextButtonPressed), for: .touchUpInside)
    }
    
    @objc private func goNextButtonPressed() {
        let loginScreenStoryboard = UIStoryboard(name: Storyboards.LoginAndSignupScreen, bundle: nil)
        if let viewController = loginScreenStoryboard.instantiateViewController(
            withIdentifier: LoginScreenTableViewController.identifier) as? LoginScreenTableViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc private func skipTapped() {
        let loginScreenStoryboard = UIStoryboard(name: Storyboards.LoginAndSignupScreen, bundle: nil)
        if let viewController = loginScreenStoryboard.instantiateViewController(
            withIdentifier: LoginScreenTableViewController.identifier) as? LoginScreenTableViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
