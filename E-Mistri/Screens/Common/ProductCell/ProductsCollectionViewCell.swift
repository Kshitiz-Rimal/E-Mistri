//
//  ProductsCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 18/01/2023.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ProductsCollectionViewCell"

    @IBOutlet weak var productCardView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSubDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }

    func setupCell(imagePath: String,
                   name: String,
                   subDescription: String,
                   price: String) {
        let changedProductpicturePath = imagePath.replacingOccurrences(
            of: "http://localhost:3000",
            with: ApiURL.baseURL
        )
        if imagePath == "" {
            productImage.image = UIImage(named: Images.brealkPad)
        } else {
            let changedProductpicturePath = imagePath.replacingOccurrences(
                of: "http://localhost:3000",
                with: ApiURL.baseURL
            )
            productImage.downloaded(from: changedProductpicturePath)
        }
        productName.text = name
        productSubDescription.text = subDescription
        productPrice.text = price
    }
    
    private func viewComponents() {
        productCardView.layer.cornerRadius = 18.0
        productCardView.layer.shadowColor = UIColor.commonShadow.cgColor
        productCardView.layer.shadowOffset = CGSize(width: 2, height: 3)
        productCardView.layer.shadowOpacity = 0.3
        productCardView.layer.shadowRadius = 40.0
        productCardView.clipsToBounds = false
        productName.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
    }
}
