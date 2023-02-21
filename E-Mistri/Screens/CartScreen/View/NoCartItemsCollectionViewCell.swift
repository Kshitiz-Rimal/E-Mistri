//
//  NoCartItemsCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 17/02/2023.
//

import UIKit

class NoCartItemsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var noItemsText: UILabel!
    
    static let identifier: String = "NoCartItemsCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }

    private func viewComponents() {
        noItemsText.text = Text.noItemText
        noItemsText.textAlignment = .center
        noItemsText.numberOfLines = 2
    }
}
