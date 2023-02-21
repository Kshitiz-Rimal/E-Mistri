//
//  CartItemCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 26/01/2023.
//

import UIKit

class CartItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cartCellView: UIView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var removeCellButton: UIButton!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var addQuantityButton: UIButton!
    @IBOutlet weak var substractQuantityBtn: UIButton!
    @IBOutlet weak var quantityCount: UILabel!
    
    static let identifier: String = "CartItemCollectionViewCell"
    var quantityNumber = 1

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        viewComponents()
    }
    
    func setupViewComponents(
        prodImage: String,
        prodName: String,
        prodDescription: String,
        prodPrice: String,
        prodQuantity: String
    ) -> Int {
        if let quantity = Int(prodQuantity) {
            quantityNumber = quantity
        }
        itemImage.image = UIImage(named: prodImage)
        itemName.text = prodName
        itemDescription.text = prodDescription
        itemPrice.text = "Rs. \(prodPrice)"
        quantityCount.text = prodQuantity
        return quantityNumber
    }
    
    private func viewComponents() {
        cartCellView.layer.cornerRadius = 16.0
        
        itemImage.layer.cornerRadius = 16.0
        itemImage.backgroundColor = .productCategoryBackgroundColor
        
        itemDescription.textColor = .detailPageGray
        
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
        quantityCount.text = String(quantityNumber)
        quantityCount.textColor = .appPrimaryColor
        
        removeCellButton.setTitle("", for: .normal)
        removeCellButton.setImage(UIImage(named: Images.closeCellImage), for: .normal)
    }
    
    @objc private func addButtonTapped() {
        quantityNumber += 1
        quantityCount.text = String(quantityNumber)
    }
    
    @objc private func substractBtnTapped() {
        if quantityNumber > 1 {
            quantityNumber -= 1
            quantityCount.text = String(quantityNumber)
        }
    }
}
