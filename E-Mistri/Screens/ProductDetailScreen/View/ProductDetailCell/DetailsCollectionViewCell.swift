//
//  DetailsCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 23/01/2023.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productStar: UIImageView!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var addToCartButton: CustomButton!
    @IBOutlet weak var addQuantityButton: UIButton!
    @IBOutlet weak var substractQuantityBtn: UIButton!
    @IBOutlet weak var quantityCount: UILabel!
    
    static let identifier: String = "DetailsCollectionViewCell"
    var qunantityNumber = 1

    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    func setupViewComponents(
        prodType: String,
        prodRating: String,
        prodName: String,
        prodPrice: String,
        prodDescription: String
    ) {
        productType.text = prodType
        productRating.text = prodRating
        productName.text = prodName
        productPrice.text = prodPrice
        productDescription.text = prodDescription
    }

    private func viewComponents() {
        detailsView.layer.cornerRadius = 20
        detailsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        productType.textColor = .detailPageGray
        
        productStar.image = UIImage(systemName: Images.star)
        productStar.tintColor = .orange
        
        productRating.textColor = .detailPageGray
        
        productDescription.textColor = .detailPageGray
        productDescription.numberOfLines = 2
        
        quantityView.backgroundColor = .productDetailBackgroundColor
        quantityView.layer.cornerRadius = quantityView.frame.height / 2
        
        substractQuantityBtn.layer.borderWidth = 1
        substractQuantityBtn.layer.borderColor = UIColor.appPrimaryColor.cgColor
        substractQuantityBtn.setTitle("", for: .normal)
        substractQuantityBtn.setImage(UIImage(named: Images.substractQuantity), for: .normal)
        substractQuantityBtn.backgroundColor = .productDetailBackgroundColor
        substractQuantityBtn.layer.cornerRadius = substractQuantityBtn.frame.height / 2
        substractQuantityBtn.tintColor = .productDetailBackgroundColor
        substractQuantityBtn.clipsToBounds = true
        substractQuantityBtn.addTarget(self, action: #selector(substractBtnTapped), for: .touchUpInside)
        
        addQuantityButton.setTitle("", for: .normal)
        addQuantityButton.setImage(UIImage(named: Images.addQuantity), for: .normal)
        addQuantityButton.tintColor = .appPrimaryColor
        addQuantityButton.layer.cornerRadius = addQuantityButton.frame.height / 2
        addQuantityButton.clipsToBounds = true
        addQuantityButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        quantityCount.textAlignment = .center
        quantityCount.text = String(qunantityNumber)
        quantityCount.textColor = .appPrimaryColor
        
        commentsButton.layer.cornerRadius = 8.0
        commentsButton.backgroundColor = .commentButtonColor
        commentsButton.setImage(UIImage(named: Images.commentBtnImage), for: .normal)
        commentsButton.clipsToBounds = true
        commentsButton.setTitle("", for: .normal)
        
        addToCartButton.setupButton(buttonTitle: Text.toCartText)
        addToCartButton.setImage(UIImage(systemName: Images.cartImg), for: .normal)
    }
    
    @objc private func addButtonTapped() {
        qunantityNumber += 1
        quantityCount.text = String(qunantityNumber)
    }
    
    @objc private func substractBtnTapped() {
        if qunantityNumber > 1 {
            qunantityNumber -= 1
            quantityCount.text = String(qunantityNumber)
        }
    }
}
