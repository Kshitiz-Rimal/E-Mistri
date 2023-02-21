//
//  EditPhotoTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 02/02/2023.
//

import UIKit

protocol EditPhotoTableViewCellDelegate: AnyObject {
    func didTapEditPhotoButton()
}

class EditPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var editPhotoButton: UIButton!
    
    static let identifier: String = "EditPhotoTableViewCell"
    let userData: UserData = Storage.shared.load(key: Text.userKey)
    weak var delegate: EditPhotoTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    private func viewComponents() {
        if userData.userProfilePicturePath == "" {
            profilePicture.image = UIImage(named: Images.noUserImage)
        } else {
            profilePicture.downloaded(from: userData.userProfilePicturePath)
        }
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
        profilePicture.contentMode = .scaleToFill
        
        editPhotoButton.setImage(UIImage(named: Images.changePhotoImage), for: .normal)
        editPhotoButton.setTitle(Text.changePhoto, for: .normal)
        editPhotoButton.setTitleColor(UIColor.profilePageGreyColor, for: .normal)
        editPhotoButton.addTarget(self, action: #selector(editPhotoButtonTapped), for: .touchUpInside)
    }
    
    @objc private func editPhotoButtonTapped() {
        delegate?.didTapEditPhotoButton()
    }
}
