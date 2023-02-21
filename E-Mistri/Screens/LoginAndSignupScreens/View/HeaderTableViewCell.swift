//
//  HeaderTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 04/01/2023.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    static let identifier: String = "HeaderTableViewCell"

    @IBOutlet weak var eMistriLogo: UIImageView!
    @IBOutlet weak var primaryText: UILabel!
    @IBOutlet weak var secondaryText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    private func viewComponents() {
        selectionStyle = .none
        eMistriLogo.image = UIImage(named: Images.EMistriLogo)
        primaryText.textAlignment = .center
        primaryText.numberOfLines = 0
        secondaryText.textAlignment = .center
        secondaryText.numberOfLines = 0
    }
}
