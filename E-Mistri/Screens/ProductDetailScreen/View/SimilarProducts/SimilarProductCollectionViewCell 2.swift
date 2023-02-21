//
//  SimilarProductCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 25/01/2023.
//

import UIKit

class SimilarProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var similarProductView: UIView!
    @IBOutlet weak var similarProductImage: UIImageView!
    @IBOutlet weak var similarProductName: UILabel!
    
    static let identifier: String = "SimilarProductCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        viewComponents()
    }
    
    func setupComponents(prodImage: String, prodName: String) {
        similarProductImage.image = UIImage(named: prodImage)
        
        similarProductName.text = prodName
    }
    
    private func viewComponents() {
        similarProductView.layer.cornerRadius = 16.0
        similarProductView.layer.shadowColor = UIColor.commonShadow.cgColor
        similarProductView.layer.shadowOffset = CGSize(width: 3, height: 3)
        similarProductView.layer.shadowOpacity = 0.3
        similarProductView.layer.shadowRadius = 20
        similarProductView.clipsToBounds = false
        
        similarProductName.textAlignment = .center
    }
}
