//
//  ProductCategoryCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 18/01/2023.
//

import UIKit

class ProductCategoryCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "ProductCategoryCollectionViewCell"
    
    @IBOutlet weak var productImageBody: UIView!
    @IBOutlet weak var productCategoryImage: UIImageView!
    @IBOutlet weak var productCategoryText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }

    private func viewComponents() {
        productImageBody.layer.cornerRadius = 16
        productImageBody.backgroundColor = .productCategoryBackgroundColor
    }
}
