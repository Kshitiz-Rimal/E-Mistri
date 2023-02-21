//
//  ProfileNavigationTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 19/01/2023.
//

import UIKit

class ProfileNavigationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileNavigationImage: UIImageView!
    @IBOutlet weak var profileNavigationText: UILabel!
    @IBOutlet weak var profileNavigationSubText: UILabel!
    @IBOutlet weak var profileNavigationButton: UIButton!
    
    static let identifier: String = "ProfileNavigationTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    private func viewComponents() {
        profileNavigationImage.backgroundColor = .profilePageBlueColor
        profileNavigationImage.layer.cornerRadius = 8.0
        
        profileNavigationSubText.textColor = .profilePageGreyColor
        
        profileNavigationButton.setImage(UIImage(systemName: Images.chevronForward), for: .normal)
    }
}
