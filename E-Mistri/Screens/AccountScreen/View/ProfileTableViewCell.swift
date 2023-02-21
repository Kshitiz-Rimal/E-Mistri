//
//  ProfileTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 19/01/2023.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileSectionView: UIView!
    @IBOutlet weak var rewardPointsView: UIView!
    @IBOutlet weak var rewardPoints: UILabel!
    @IBOutlet weak var rewardPointsText: UILabel!
    @IBOutlet weak var rewardPointsRibbonImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    
    static let identifier: String = "ProfileTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    func setupComponents(profileImageURL: String, userName: String, userEmail: String) {
        if profileImageURL == "" {
            profileImage.image = UIImage(named: Images.noUserImage)
        } else {
//            profileImage.load(url: profileImageURL)
            profileImage.downloaded(from: profileImageURL)
        }
        profileName.text = userName
        profileEmail.text = userEmail
    }
    
    private func viewComponents() {
        let gradientView = CAGradientLayer()
        profileSectionView.clipsToBounds = true
        gradientView.colors = [
            UIColor.white.cgColor,
            UIColor.gradientBlue.cgColor
        ]
        gradientView.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: frame.height+10)
        profileSectionView.layer.insertSublayer(gradientView, at: 0)
        gradientView.startPoint = CGPoint(x: 0.5, y: 0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1)
        profileSectionView.layer.cornerRadius = 50
        profileSectionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.contentMode = .scaleAspectFill
        
        profileName.textAlignment = .center
        
        profileEmail.textAlignment = .center
        profileEmail.textColor = .profilePageGreyColor
        
        rewardPointsView.layer.cornerRadius = 13.0
        rewardPointsView.layer.shadowColor = UIColor.gradientBlue.cgColor
        rewardPointsView.layer.shadowOffset = CGSize(width: 2, height: 0.4)
        rewardPointsView.layer.shadowOpacity = 1
        rewardPointsView.layer.shadowRadius = 13.0
        rewardPointsView.clipsToBounds = false
        
        rewardPointsRibbonImage.image = UIImage(named: Images.rewardPointRibbon)
        
        rewardPointsText.text = Text.rewardPointsText
        rewardPointsText.textColor = .profilePageGreyColor
        
        rewardPoints.text = Text.rewardPoints
        
        checkmarkImage.image = UIImage(named: Images.checkmarkImage)
    }
}
