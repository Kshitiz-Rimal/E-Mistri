//
//  SecondOnBoardingScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 28/12/2022.
//

import UIKit

class SecondOnBoardingScreenViewController: UIViewController {
    
    @IBOutlet weak var curvedBottomImage: UIImageView!
    @IBOutlet weak var mechanicImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    @IBOutlet weak var goNextButton: RoundedButton!
    
    static let identifier: String = "SecondOnBoardingScreenViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navbarComponents()
        viewComponents()
    }
            
    func viewComponents() {
        curvedBottomImage.image = UIImage(named: Images.CurvedBottomImage)
        mechanicImage.image = UIImage(named: Images.CallMechanic)
        titleText.numberOfLines = 0
        titleText.textAlignment = .center
        titleText.text = Text.titleTextSecondOnboardingScreen
        titleText.font = .boldSystemFont(ofSize: FontSize.titleFontSize)
        bodyText.numberOfLines = 0
        bodyText.textAlignment = .center
        bodyText.text = Text.bodyTextSecondOnboardingScreen
        if let imageView = goNextButton.imageView {
            goNextButton.bringSubviewToFront(imageView)
        }
        goNextButton.addTarget(self, action: #selector(goNextButtonPressed), for: .touchUpInside)
    }
    
    @objc private func navbarComponents() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(skipTapped))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(
            systemName: Images.backButton
        )
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: Images.backButton)
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func goNextButtonPressed() {
        if let toThirdOnboardigScreen = storyboard?.instantiateViewController(
            withIdentifier: ThirdOnBoardingScreenViewController.identifier
        ) as? ThirdOnBoardingScreenViewController {
            navigationController?.pushViewController(toThirdOnboardigScreen, animated: true)
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
