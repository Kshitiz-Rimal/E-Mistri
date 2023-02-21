//
//  SettingsScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 31/01/2023.
//

import UIKit

class SettingsScreenViewController: UIViewController {
    
    @IBOutlet weak var goBackButton: CustomBackButton!
    @IBOutlet weak var settingeScreenTitle: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    static let identifier: String = "SettingsScreenViewController"
    let settings: [Settings] = [
        Settings(
            settingImage: Images.changePasswordImage,
            settingTitle: "Change Password"
        ),
        Settings(
            settingImage: Images.changelanguageImage,
            settingTitle: "Change Language"
        ),
        Settings(
            settingImage: Images.notificationImage,
            settingTitle: "Notification"
        ),
        Settings(
            settingImage: Images.themeImage,
            settingTitle: "Dark Mode"
        ),
        Settings(
            settingImage: Images.privacyPolicyImage,
            settingTitle: "Privacy policy"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        viewComponents()
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(
            UINib(
                nibName: SettingsTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: SettingsTableViewCell.identifier
        )
        settingsTableView.separatorStyle = .none
    }
    
    private func viewComponents() {
        settingeScreenTitle.text = "Settings"
        settingeScreenTitle.textAlignment = .center
        
        goBackButton.setupButton(buttonImage: Images.chevronBackward)
        goBackButton.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingcell = settingsTableView.dequeueReusableCell(
            withIdentifier: SettingsTableViewCell.identifier,
            for: indexPath
        ) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        settingcell.setupViewComponents(
            cellImage: settings[indexPath.row].settingImage,
            cellTitle: settings[indexPath.row].settingTitle
        )
        settingcell.selectionStyle = .none
        return settingcell
    }
}

extension SettingsScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let changePasswordScreenStoryboard = UIStoryboard(name: Storyboards.ChangePasswordScreen, bundle: nil)
            guard let viewController = changePasswordScreenStoryboard.instantiateViewController(
                withIdentifier: ChangePasswordScreenViewController.identifier
            ) as? ChangePasswordScreenViewController else { return }
            navigationController?.pushViewController(viewController, animated: true)
            
        default:
            print("Tap recognized")
        }
    }
}
