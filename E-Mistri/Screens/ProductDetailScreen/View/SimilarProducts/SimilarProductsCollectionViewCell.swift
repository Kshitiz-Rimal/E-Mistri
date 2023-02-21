//
//  SimilarProductsCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 25/01/2023.
//

import UIKit

class SimilarProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var similarproductsText: UILabel!
    @IBOutlet weak var similarProductsCollectionView: UICollectionView!
    
    static let identifier: String = "SimilarProductsCollectionViewCell"
    let similarProd: [SimilarProducts] = [
        SimilarProducts(
            prodImage: Images.engineFilter,
            prodName: "FZ Air Filter"
        ),
        SimilarProducts(
            prodImage: Images.brealkPad,
            prodName: "Break Pad"
        ),
        SimilarProducts(
            prodImage: Images.gearBox,
            prodName: "Gear Box"
        ),
        SimilarProducts(
            prodImage: Images.engineFilter,
            prodName: "Engine Filter"
        )
    ]

    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
        
        similarProductsCollectionView.showsHorizontalScrollIndicator = false
        similarProductsCollectionView.dataSource = self
        similarProductsCollectionView.delegate = self
        similarProductsCollectionView.register(
            UINib(
                nibName: SimilarProductCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: SimilarProductCollectionViewCell.identifier
        )
    }
    
    private func viewComponents() {
        similarproductsText.text = Text.similarProducts
    }
}

extension SimilarProductsCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarProd.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let similarProducts = similarProductsCollectionView.dequeueReusableCell(
            withReuseIdentifier: SimilarProductCollectionViewCell.identifier,
            for: indexPath
        ) as? SimilarProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        similarProducts.setupComponents(
            prodImage: similarProd[indexPath.row].prodImage,
            prodName: similarProd[indexPath.row].prodName
        )
        return similarProducts
    }
}

extension SimilarProductsCollectionViewCell: UICollectionViewDelegate {
    
}

extension SimilarProductsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: 100,
            height: 150
        )
    }
}
