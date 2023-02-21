//
//  ProductDetailsViewController.swift
//  E-Mistri
//
//  Created by gurzu on 23/01/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var backButton: CustomBackButton!
    @IBOutlet weak var favouriteButton: CustomBackButton!
    @IBOutlet weak var productDetailCollectionView: UICollectionView!
    
    static let identifier: String = "ProductDetailsViewController"
    let productDetails: [ProductDetails] = [
        ProductDetails(
            prodType: Text.prodType,
            prodRating: Text.prodRating,
            prodName: Text.prodName,
            prodPrice: Text.prodPrice,
            prodDescription: Text.prodDescription
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .productDetailBackgroundColor
        
        productDetailCollectionView.showsVerticalScrollIndicator = false
        productDetailCollectionView.delegate = self
        productDetailCollectionView.dataSource = self
        productDetailCollectionView.register(
            UINib(
                nibName: ProductImageCarousalCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: ProductImageCarousalCollectionViewCell.identifier
        )
        productDetailCollectionView.register(
            UINib(
                nibName: DetailsCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: DetailsCollectionViewCell.identifier)
        productDetailCollectionView.register(
            UINib(
                nibName: SimilarProductsCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: SimilarProductsCollectionViewCell.identifier
        )
        viewComponents()
    }
    
    private func viewComponents() {
        backButton.setupButton(buttonImage: Images.chevronBackward)
        backButton.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        
        favouriteButton.setupButton(buttonImage: Images.favourite)
        favouriteButton.setupButton(buttonImage: Images.heartFill)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func favouriteButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }) { _ in
            UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
}

extension ProductDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = indexPath.section
        if section == 0 {
            guard let productImageCarousal = productDetailCollectionView.dequeueReusableCell(
                withReuseIdentifier: ProductImageCarousalCollectionViewCell.identifier,
                for: indexPath
            ) as? ProductImageCarousalCollectionViewCell else {
                return UICollectionViewCell()
            }
            return productImageCarousal
        } else if section == 1 {
            guard let productDetail = productDetailCollectionView.dequeueReusableCell(
                withReuseIdentifier: DetailsCollectionViewCell.identifier,
                for: indexPath
            ) as? DetailsCollectionViewCell else {
                return UICollectionViewCell()
            }
            productDetail.setupViewComponents(
                prodType: productDetails[indexPath.row].prodType,
                prodRating: productDetails[indexPath.row].prodRating,
                prodName: productDetails[indexPath.row].prodName,
                prodPrice: productDetails[indexPath.row].prodPrice,
                prodDescription: productDetails[indexPath.row].prodDescription
            )
            return productDetail
        } else {
            guard let similarProductCell = productDetailCollectionView.dequeueReusableCell(
                withReuseIdentifier: SimilarProductsCollectionViewCell.identifier,
                for: indexPath
            ) as? SimilarProductsCollectionViewCell else {
                return UICollectionViewCell()
            }
            return similarProductCell
        }
    }
}

extension ProductDetailsViewController: UICollectionViewDelegate {
    
}

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            return CGSize(
                width: productDetailCollectionView.bounds.width,
                height: UIScreen.main.bounds.size.height / 2 - 100
            )
        } else if section == 1 {
            return CGSize(
                width: UIScreen.main.bounds.size.width,
                height: 200
            )
        } else {
            return CGSize(
                width: UIScreen.main.bounds.size.width,
                height: 230
            )
        }
    }
}
