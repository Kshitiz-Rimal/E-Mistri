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
    
    func setupImage(productImage: String, productImagePath: String) {
        if productImagePath == "" {
            productImages.image = UIImage(named: productImage)
        } else {
            let changedProductpicturePath = productImagePath.replacingOccurrences(
                of: "http://localhost:3000",
                with: ApiURL.baseURL
            )
            productImages.downloaded(from: changedProductpicturePath)
        }
    }
}
