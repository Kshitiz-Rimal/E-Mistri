//
//  ForYouScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 16/01/2023.
//

import UIKit
import Alamofire

class ForYouScreenViewController: UIViewController {
    
    @IBOutlet weak var searchbar: CustomTextField!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var dashboardCollectionView: UICollectionView!
    
    var productList: [Products]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let token = KeyChain.getKeyChain()
        print(token)
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        dashboardCollectionView.dataSource = self
        dashboardCollectionView.delegate = self
        dashboardCollectionView.register(
            UINib(
                nibName: CarouselCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier
        )
        dashboardCollectionView.register(
            UINib(
                nibName: ProductCategoriesCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: ProductCategoriesCollectionViewCell.identifier
        )
        dashboardCollectionView.register(
            UINib(
                nibName: ProductSectionCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: ProductSectionCollectionViewCell.identifier
        )
        dashboardCollectionView.showsVerticalScrollIndicator = false
        viewComponents()
        
        productsListResponse()
    }
    
    private func viewComponents() {
        searchbar.setupTextField(placeholderText: Text.searchTextFieldText)
        searchbar.borderStyle = .none
        searchbar.layer.cornerRadius = 12.0
       
        sortButton.tintColor = .appPrimaryColor
        sortButton.setImage(UIImage(named: Images.sortButtonImage), for: .normal)
        sortButton.layer.cornerRadius = 9.0
    }
    
    private func productsListResponse() {
        let token = KeyChain.getKeyChain()
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        AF.request(ApiURL.getProductsList,
                   method: .get,
                   headers: header
        ).validate().responseDecodable(of: [Products].self) { response in
            switch response.result {
            case .success(let productsList):
                print(productsList)
                print("JKSDBJKb LASDKNlkdn::::::::", productsList[1].name)
                self.productList = productsList
                self.dashboardCollectionView.reloadData()
                
            case .failure(let error):
                print("Error::", error)
            }
        }
    }
}

extension ForYouScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = indexPath.item
        if section == 0 {
            if let carouselCell = dashboardCollectionView.dequeueReusableCell(
                withReuseIdentifier: CarouselCollectionViewCell.identifier,
                for: indexPath
            ) as? CarouselCollectionViewCell {
                return carouselCell
            }
        } else if section == 1 {
            if let productCategoryCell = dashboardCollectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCategoriesCollectionViewCell.identifier,
                for: indexPath
            ) as? ProductCategoriesCollectionViewCell {
                return productCategoryCell
            }
        } else {
            if let productSection = dashboardCollectionView.dequeueReusableCell(
                withReuseIdentifier: ProductSectionCollectionViewCell.identifier,
                for: indexPath
            ) as? ProductSectionCollectionViewCell {
                print("Main Controller::", productList)
                productSection.productsList = productList
                productSection.delegate = self
                return productSection
            }
        }
        return UICollectionViewCell()
    }
}
    
extension ForYouScreenViewController: UICollectionViewDelegate {
    
}

extension ForYouScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let section = indexPath.item
        if section == 0 {
            return CGSize(
                width: dashboardCollectionView.bounds.width - 30,
                height: 230
            )
        } else if section == 1 {
            return CGSize(
                width: dashboardCollectionView.bounds.width - 30,
                height: 90
            )
        } else {
            return CGSize(
                width: dashboardCollectionView.bounds.width - 30,
                height: dashboardCollectionView.bounds.height
            )
        }
    }
}

extension ForYouScreenViewController: ProductSectionCollectionViewCellDelegate {
    func cellTapped(indexPath: IndexPath) {
        guard let products = productList else {return}
        print("Item Tapped::::", products[indexPath.row])
        let productDetailScreenStoryboard = UIStoryboard(name: Storyboards.ProductDetailScreen, bundle: nil)
        guard let viewController = productDetailScreenStoryboard.instantiateViewController(
            withIdentifier: ProductDetailsViewController.identifier) as? ProductDetailsViewController else {
            return
        }
        viewController.productDet = products[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
