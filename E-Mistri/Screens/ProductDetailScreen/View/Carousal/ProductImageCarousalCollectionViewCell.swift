//
//  ProductImageCarousalCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 23/01/2023.
//

import UIKit

class ProductImageCarousalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageCarousel: UICollectionView!
    
    static let identifier: String = "ProductImageCarousalCollectionViewCell"
    let productImages: [ProductImages] = [
        ProductImages(productImage: Images.brealkPad),
        ProductImages(productImage: Images.engineFilter),
        ProductImages(productImage: Images.gearBox)
    ]
    var imagePath: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageCarousel.showsHorizontalScrollIndicator = false
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        productImageCarousel.collectionViewLayout = flowLayout
        productImageCarousel.isPagingEnabled = true
        productImageCarousel.dataSource = self
        productImageCarousel.delegate = self
        productImageCarousel.register(
            UINib(
                nibName: ProductsImageCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: ProductsImageCollectionViewCell.identifier
        )
    }
    
    func setupProductImages(productImagePath: String) {
        imagePath = productImagePath
    }
}

extension ProductImageCarousalCollectionViewCell: UICollectionViewDelegate {
    
}

extension ProductImageCarousalCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let productImageCell = productImageCarousel.dequeueReusableCell(
            withReuseIdentifier: ProductsImageCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductsImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        if imagePath == "" {
            productImageCell.setupImage(productImage: productImages[indexPath.row].productImage,
                                        productImagePath: imagePath)
        } else {
            productImageCell.setupImage(productImage: productImages[indexPath.row].productImage,
                                        productImagePath: imagePath)
        }
        return productImageCell
    }
}

extension ProductImageCarousalCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.bounds.size.width, height: 300)
    }
}
