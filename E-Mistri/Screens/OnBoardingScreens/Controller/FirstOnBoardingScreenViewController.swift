//
//  FirstOnBoardingScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 26/12/2022.
//

import UIKit

class FirstOnBoardingScreenViewController: UIViewController {
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var mechanicImage: UIImageView!
    @IBOutlet weak var curvedBottomImage: UIImageView!
    @IBOutlet weak var bodyText: UILabel!
    @IBOutlet weak var goNextButton: RoundedButton!
    
    static let identifier: String = "FirstOnBoardingScreenViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(skipTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func viewComponents() {
        curvedBottomImage.image = UIImage(named: Images.CurvedBottomImage)
        mechanicImage.image = UIImage(named: Images.VehicleMechanic)
        titleText.numberOfLines = 2
        titleText.textAlignment = .center
        titleText.text = Text.titleTextFirstOnboardingScreen
        titleText.font = .boldSystemFont(ofSize: FontSize.titleFontSize)
        bodyText.numberOfLines = 0
        bodyText.textAlignment = .center
        bodyText.text = Text.bodyTextFirstOnboardingScreen
        if let imageView = goNextButton.imageView {
            goNextButton.bringSubviewToFront(imageView)
        }
        goNextButton.addTarget(self, action: #selector(goNextButtonPressed), for: .touchUpInside)
    }
    
    @objc private func goNextButtonPressed() {
        if let toSecondOnboardigScreen = storyboard?.instantiateViewController(
            withIdentifier: SecondOnBoardingScreenViewController.identifier
        ) as? SecondOnBoardingScreenViewController {
            navigationController?.pushViewController(toSecondOnboardigScreen, animated: true)
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
