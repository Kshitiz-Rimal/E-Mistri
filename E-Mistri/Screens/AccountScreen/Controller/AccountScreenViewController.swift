//
//  AccountScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 16/01/2023.
//

import UIKit
import Alamofire

class AccountScreenViewController: UIViewController {

    @IBOutlet weak var accountScreenTableView: UITableView!
    @IBOutlet weak var logoutImage: UIImageView!
    @IBOutlet weak var logoutText: UILabel!
    @IBOutlet weak var logoutSubText: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var seperatorForLogout: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    let accountNavigation: [AccountScreenNavComponents] = [
        AccountScreenNavComponents(
            profileNavigationImage: Images.personImage,
            profileNavigationText: Text.profileNavigationMyInformation,
            profileNavigationSubText: Text.profileNavigationMyInformationSubText
        ),
        AccountScreenNavComponents(
            profileNavigationImage: Images.settingImage,
            profileNavigationText: Text.profileNavigationSettings,
            profileNavigationSubText: Text.profileNavigationSettingsSubText
        ),
        AccountScreenNavComponents(
            profileNavigationImage: Images.shareImage,
            profileNavigationText: Text.profileNavigationShare,
            profileNavigationSubText: Text.profileNavigationShareSubText
        ),
        AccountScreenNavComponents(
            profileNavigationImage: Images.aboutusImage,
            profileNavigationText: Text.profileNavigationAboutUs,
            profileNavigationSubText: Text.profileNavigationAboutUsSubText
        )
    ]
    var userData: UserData = Storage.shared.load(key: Text.userKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountScreenTableView.delegate = self
        accountScreenTableView.dataSource = self
        accountScreenTableView.register(
            UINib(
                nibName: ProfileTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: ProfileTableViewCell.identifier
        )
        accountScreenTableView.register(
            UINib(
                nibName: ProfileNavigationTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: ProfileNavigationTableViewCell.identifier
        )
        accountScreenTableView.separatorStyle = .none
        viewComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userData = Storage.shared.load(key: Text.userKey)
        accountScreenTableView.reloadData()
    }
    
    private func viewComponents() {
        logoutImage.layer.cornerRadius = 8.0
        logoutImage.image = UIImage(named: Images.logoutImage)
        
        logoutText.text = Text.logoutText
        
        logoutSubText.text = Text.logoutSubText
        logoutSubText.textColor = .profilePageGreyColor
        
        logOutButton.setImage(UIImage(systemName: Images.chevronForward), for: .normal)
        
        seperatorForLogout.backgroundColor = .seperatorColor
        
        let tappedLogout = UITapGestureRecognizer(target: self, action: #selector(logoutTapped))
        logoutView.addGestureRecognizer(tappedLogout)
    }
    
    @objc private func logoutTapped() {
        let alert = UIAlertController(
            title: Text.conformationText,
            message: .none,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "Yes",
            style: .destructive,
            handler: { [weak self] (_: UIAlertAction!) in
                self?.navToLogin()
            }
        )
        )
        alert.addAction(UIAlertAction(
            title: "No",
            style: .default
        )
        )
       present(alert, animated: true)
        accountScreenTableView.separatorStyle = .none
    }
    
    private func navToLogin() {
        let token = KeyChain.getKeyChain()
        print("askjdbkjsdb:::::::::", token)
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        AF.request(ApiURL.signOutURL,
                   method: .delete,
                   headers: header
        ).validate().response { response in
            switch response.result {
            case .success(let postResponse):
                debugPrint("Success::::::", postResponse)
                
                self.userData.userIsActive = false
                Storage.shared.save(value: self.userData, key: Text.userKey)
                
                let loginScreenStoryboard = UIStoryboard(name: Storyboards.LoginAndSignupScreen, bundle: nil)
                guard let viewController = loginScreenStoryboard.instantiateViewController(
                    withIdentifier: LoginScreenTableViewController.identifier) as? LoginScreenTableViewController else {
                    return
                }
                self.navigationController?.pushViewController(viewController, animated: false)
                KeyChain.setKeyChain(userToken: "")
                
            case .failure(let error):
                print("Error:::::::", error)
            }
        }
    }
}

extension AccountScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return accountNavigation.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            if let profileSection = accountScreenTableView.dequeueReusableCell(
                withIdentifier: ProfileTableViewCell.identifier,
                for: indexPath
            ) as? ProfileTableViewCell {
                profileSection.setupComponents(profileImageURL: userData.userProfilePicturePath,
                                               userName: userData.userName,
                                               userEmail: userData.userEmail)
                profileSection.selectionStyle = .none
                profileSection.selectionStyle = .none
                return profileSection
            }
        } else {
            if let profileNavigationSection = accountScreenTableView.dequeueReusableCell(
                withIdentifier: ProfileNavigationTableViewCell.identifier,
                for: indexPath
            ) as? ProfileNavigationTableViewCell {
                profileNavigationSection.profileNavigationImage.image = UIImage(
                    named: accountNavigation[
                        indexPath.row
                    ].profileNavigationImage
                )
                profileNavigationSection.profileNavigationText.text = accountNavigation[
                    indexPath.row
                ].profileNavigationText
                profileNavigationSection.profileNavigationSubText.text = accountNavigation[
                    indexPath.row
                ].profileNavigationSubText
                profileNavigationSection.selectionStyle = .none
                return profileNavigationSection
            }
        }
        return UITableViewCell()
    }
}

extension AccountScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 1 {
            switch indexPath.row {
            case 0:
                let profileScreenStoryboard = UIStoryboard(name: Storyboards.ProfileScreen, bundle: nil)
                guard let viewController = profileScreenStoryboard.instantiateViewController(
                    withIdentifier: ProfileScreenViewController.identifier
                ) as? ProfileScreenViewController else { return }
                navigationController?.pushViewController(viewController, animated: true)
                
            case 1:
                let settingScreenStoryboard = UIStoryboard(name: Storyboards.settingScreen, bundle: nil)
                guard let viewController = settingScreenStoryboard.instantiateViewController(
                    withIdentifier: SettingsScreenViewController.identifier)
                        as? SettingsScreenViewController else { return }
                navigationController?.pushViewController(viewController, animated: true)
                
            default:
                print("Tap recognized")
            }
        }
    }
}
