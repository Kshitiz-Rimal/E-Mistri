//
//  ProductSectionCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 18/01/2023.
//

import UIKit

protocol ProductSectionCollectionViewCellDelegate: AnyObject {
    func cellTapped(indexPath: IndexPath)
}

class ProductSectionCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ProductSectionCollectionViewCell"
    let popularProducts: [ProductData] = [
        ProductData(
            productImage: Images.engineFilter,
            productName: "Engine Filter",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        ProductData(
            productImage: Images.brealkPad,
            productName: "Break Pad",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        ProductData(
            productImage: Images.gearBox,
            productName: "Gear Box",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        )
    ]
    let recommendedProducts: [ProductData] = [
        ProductData(
            productImage: Images.gearBox,
            productName: "Gear Box",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        ProductData(
            productImage: Images.engineFilter,
            productName: "Engine Filter",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        ProductData(
            productImage: Images.brealkPad,
            productName: "Break Pad",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        ProductData(
            productImage: Images.gearBox,
            productName: "Gear Box",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        ProductData(
            productImage: Images.engineFilter,
            productName: "Engine Filter",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        ProductData(
            productImage: Images.brealkPad,
            productName: "Break Pad",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        )
    ]
    var productsList: [Products]?
    weak var delegate: ProductSectionCollectionViewCellDelegate?

    @IBOutlet weak var productTypeSegmentedView: UISegmentedControl!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(
            UINib(
                nibName: ProductsCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: ProductsCollectionViewCell.identifier
        )
        viewComponents()
        print("Popular Products:::::", productsList)
    }
    
    private func viewComponents() {
        productTypeSegmentedView.backgroundColor = .productCategoryBackgroundColor
        productTypeSegmentedView.layer.cornerRadius = 13.0
        productTypeSegmentedView.selectedSegmentTintColor = .appPrimaryColor
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        productTypeSegmentedView.setTitleTextAttributes(titleTextAttributes, for: .selected)
        productTypeSegmentedView.setTitle("Popular Product", forSegmentAt: 0)
        productTypeSegmentedView.setTitle("Top Rated", forSegmentAt: 1)
        productTypeSegmentedView.setTitle("Recommended", forSegmentAt: 2)
        productTypeSegmentedView.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc private func segmentChanged() {
        productsCollectionView.reloadData()
    }
}

extension ProductSectionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if productTypeSegmentedView.selectedSegmentIndex == 0 {
            return popularProducts.count
        } else if productTypeSegmentedView.selectedSegmentIndex == 1 {
            guard let products = productsList else {
                return 0
            }
            return products.count
        } else {
            return recommendedProducts.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        if let productCell = productsCollectionView.dequeueReusableCell(
            withReuseIdentifier: ProductsCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductsCollectionViewCell {
            if productTypeSegmentedView.selectedSegmentIndex == 0 {
                productCell.productName.text = popularProducts[indexPath.row].productName
                productCell.productImage.image = UIImage(named: popularProducts[indexPath.row].productImage)
                productCell.productSubDescription.text = popularProducts[indexPath.row].productSubDescription
                productCell.productPrice.text = popularProducts[indexPath.row].productPrice
                return productCell
            } else if productTypeSegmentedView.selectedSegmentIndex == 1 {
                guard let products = productsList else {
                    return UICollectionViewCell()
                }
                productCell.productName.text = products[indexPath.row].name
                if products[indexPath.row].productImagePath == "" {
                    productCell.productImage.image = UIImage(named: Images.brealkPad)
                } else {
                    let changedProductpicturePath = products[indexPath.row].productImagePath.replacingOccurrences(
                        of: "http://localhost:3000",
                        with: ApiURL.baseURL
                    )
                    productCell.productImage.downloaded(from: changedProductpicturePath)
                }
                productCell.productSubDescription.text = products[indexPath.row].productDescription
                productCell.productPrice.text = String(products[indexPath.row].price)
                return productCell
            } else {
                productCell.productName.text = recommendedProducts[indexPath.row].productName
                productCell.productImage.image = UIImage(named: recommendedProducts[indexPath.row].productImage)
                productCell.productSubDescription.text = recommendedProducts[indexPath.row].productSubDescription
                productCell.productPrice.text = recommendedProducts[indexPath.row].productPrice
                return productCell
            }
        }
        return UICollectionViewCell()
    }
}

extension ProductSectionCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellTapped(indexPath: indexPath)
    }
}

extension ProductSectionCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: self.bounds.size.width/2-5,
            height: 300
        )
    }
}
