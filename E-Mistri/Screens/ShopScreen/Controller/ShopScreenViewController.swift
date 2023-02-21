//
//  ShopScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 16/01/2023.
//

import UIKit
import Alamofire

class ShopScreenViewController: UIViewController {

    @IBOutlet weak var shopScreenTitle: UILabel!
    @IBOutlet weak var searchbar: CustomTextField!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var allProductsCollectionView: UICollectionView!
    
    let allProducts: [AllProductData] = [
        AllProductData(
            productImage: Images.gearBox,
            productName: "Gear Box",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.engineFilter,
            productName: "Engine Filter",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.brealkPad,
            productName: "Break Pad",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.gearBox,
            productName: "Gear Box",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.engineFilter,
            productName: "Engine Filter",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.brealkPad,
            productName: "Break Pad",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.gearBox,
            productName: "Gear Box",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.engineFilter,
            productName: "Engine Filter",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.brealkPad,
            productName: "Break Pad",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.gearBox,
            productName: "Gear Box",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.engineFilter,
            productName: "Engine Filter",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        ),
        AllProductData(
            productImage: Images.brealkPad,
            productName: "Break Pad",
            productSubDescription: "LOREM IPSUM",
            productPrice: "Rs. 1999"
        )
    ]
    var allproduct: [Products]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
        allProductsCollectionView.delegate = self
        allProductsCollectionView.dataSource = self
        allProductsCollectionView.register(
            UINib(
                nibName: ProductsCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: ProductsCollectionViewCell.identifier
        )
        productsListResponse()
    }
    
    private func viewComponents() {
        shopScreenTitle.text = Text.shopScreenTitle
        shopScreenTitle.textAlignment = .center
        
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
                self.allproduct = productsList
                self.allProductsCollectionView.reloadData()
                
            case .failure(let error):
                print("Error::", error)
            }
        }
    }
}

extension ShopScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let allprod = allproduct else {
            return 0
        }
        return allprod.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let productCell = allProductsCollectionView.dequeueReusableCell(
            withReuseIdentifier: ProductsCollectionViewCell.identifier,
            for: indexPath
        ) as? ProductsCollectionViewCell else {
            return UICollectionViewCell()
        }
        productCell.setupCell(imagePath: allproduct[indexPath.row].productImagePath,
                              name: allproduct[indexPath.row].name,
                              subDescription: allproduct[indexPath.row].productDescription,
                              price: String(allproduct[indexPath.row].price))
        return productCell
    }
    
}

extension ShopScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let products = allproduct else {return}
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

extension ShopScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: allProductsCollectionView.bounds.width/2 - 5,
            height: 300
        )
    }
}
