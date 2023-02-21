//
//  SettingsTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 31/01/2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingTitle: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    @IBOutlet weak var settingsNavigationButton: UIButton!
    
    static let identifier: String = "SettingsTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    func setupViewComponents(cellImage: String, cellTitle: String) {
        if cellTitle == "Notification" || cellTitle == "Dark Mode" {
            settingsNavigationButton.isHidden = true
        } else {
            settingSwitch.isHidden = true
        }
        settingImage.image = UIImage(named: cellImage)
        settingTitle.text = cellTitle
    }
    
    private func viewComponents() {
        settingSwitch.onTintColor = .appPrimaryColor
        settingSwitch.isOn = false
        
        settingImage.layer.cornerRadius = 8.0
        
        settingsNavigationButton.setImage(UIImage(systemName: Images.chevronForward), for: .normal)
    }
}
