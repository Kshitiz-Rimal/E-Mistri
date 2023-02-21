//
//  ProductCategoriesCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 16/01/2023.
//

import UIKit

class ProductCategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ProductCategoriesCollectionViewCell"
    let productCategory: [ProductCategoriesData] = [
        ProductCategoriesData(
            productImage: Images.productCategoryBike,
            productName: Text.productCategoryBike
        ),
        ProductCategoriesData(
            productImage: Images.productCategoryScooty,
            productName: Text.productCategoryScooty
        ),
        ProductCategoriesData(
            productImage: Images.productCategoryCar,
            productName: Text.productCategoryCar
        ),
        ProductCategoriesData(
            productImage: Images.productCategoryAccessories,
            productName: Text.productCategoryAccessories
        )
    ]

    @IBOutlet weak var productCategoryCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productCategoryCell.showsHorizontalScrollIndicator = false
        productCategoryCell.dataSource = self
        productCategoryCell.delegate = self
        productCategoryCell.register(
            UINib(
                nibName: ProductCategoryCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: ProductCategoryCollectionViewCell.identifier
        )
    }
}

extension ProductCategoriesCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = indexPath.section
        if section == 0 {
            if let productCategoryCell = productCategoryCell.dequeueReusableCell(
                withReuseIdentifier: ProductCategoryCollectionViewCell.identifier,
                for: indexPath
            ) as? ProductCategoryCollectionViewCell {
                productCategoryCell.productCategoryImage.image = UIImage(
                    named: productCategory[indexPath.row].productImage
                )
                productCategoryCell.productCategoryText.text = productCategory[indexPath.row].productName
                return productCategoryCell
            }
        }
        return UICollectionViewCell()
    }
}

extension ProductCategoriesCollectionViewCell: UICollectionViewDelegate {
    
}

extension ProductCategoriesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 85, height: 90)
    }
}
