//
//  ProductsImageCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 23/01/2023.
//

import UIKit

class ProductsImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImages: UIImageView!
    
    static let identifier: String = "ProductsImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupImage(productImage: String) {
        productImages.image = UIImage(named: productImage)
    }
}
