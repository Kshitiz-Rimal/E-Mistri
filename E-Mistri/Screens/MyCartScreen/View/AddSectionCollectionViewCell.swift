//
//  AddSectionCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 27/01/2023.
//

import UIKit

class AddSectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addIcon: UIImageView!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addView: UIView!
    
    static let identifier: String = "AddSectionCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponent()
    }

    private func viewComponent() {
        addView.layer.cornerRadius = 8.0
        
        addIcon.image = UIImage(named: Images.addIcon)
        
        addLabel.text = Text.addLabel
        addLabel.textColor = .profilePageGreyColor
        
        addImage.image = UIImage(named: Images.addImage)
    }
}
