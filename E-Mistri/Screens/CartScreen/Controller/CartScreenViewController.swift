//
//  CartScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 16/01/2023.
//

import UIKit

class CartScreenViewController: UIViewController {
    
    @IBOutlet weak var cartScreenTitle: UILabel!
    @IBOutlet weak var cartItemCollectionView: UICollectionView!
    @IBOutlet weak var checkoutView: UIView!
    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var checkoutButton: CustomButton!
    
    static let identifier: String = "CartScreenViewController"
    var itemDetails: [CartItemDetails] = [
        CartItemDetails(
            itemImage: Images.brealkPad,
            itemName: "FZ Break Pad",
            itemSubDescription: "Amet minim mollit",
            itemPrice: 1999,
            itemQuantity: 1
        ),
        CartItemDetails(
            itemImage: Images.engineFilter,
            itemName: "FZ Air Filter",
            itemSubDescription: "Amet minim mollit",
            itemPrice: 1999,
            itemQuantity: 4
        ),
        CartItemDetails(
            itemImage: Images.gearBox,
            itemName: "FZ Gear Box",
            itemSubDescription: "Amet minim mollit",
            itemPrice: 1999,
            itemQuantity: 2
        ),
        CartItemDetails(
            itemImage: Images.engineFilter,
            itemName: "Duke Air Filter",
            itemSubDescription: "Amet minim mollit",
            itemPrice: 1999,
            itemQuantity: 3
        )
    ]
    var cartItems: [CartItemDetails]?
    var totalCost: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
        setupCollectionView()
        cartItems = itemDetails
    }
    
    private func viewComponents() {
        view.backgroundColor = .productDetailBackgroundColor
        
        cartScreenTitle.text = Text.cartScreenTitle
        cartScreenTitle.textAlignment = .center
        
        checkoutView.layer.cornerRadius = 16.0
        checkoutView.layer.shadowColor = UIColor.commonShadow.cgColor
        checkoutView.layer.shadowOffset = CGSize(width: 2, height: 3)
        checkoutView.layer.shadowOpacity = 0.3
        checkoutView.layer.shadowRadius = 40.0
        checkoutView.clipsToBounds = false
        checkoutView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        totalText.text = "Total"
        totalText.textColor = .detailPageGray
        
        let cost = calculateTotalCost(details: itemDetails)
        totalPrice.text = "Rs. \(String(cost))"
        
        checkoutButton.setupButton(buttonTitle: "Checkout")
        checkoutButton.addTarget(self, action: #selector(checkoutBtnTapped), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 20
        cartItemCollectionView.collectionViewLayout = flowLayout
        cartItemCollectionView.backgroundColor = .productDetailBackgroundColor
        cartItemCollectionView.dataSource = self
        cartItemCollectionView.delegate = self
        
        cartItemCollectionView.register(
            UINib(
                nibName: CartItemCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: CartItemCollectionViewCell.identifier
        )
        
        cartItemCollectionView.register(
            UINib(
                nibName: NoCartItemsCollectionViewCell.identifier,
                bundle: nil
            ), forCellWithReuseIdentifier: NoCartItemsCollectionViewCell.identifier
        )
    }
    
    @objc private func checkoutBtnTapped() {
        let toMyCartScreen = UIStoryboard(name: Storyboards.MyCartScreenStoryBoard, bundle: nil)
        guard let viewController = toMyCartScreen.instantiateViewController(
            withIdentifier: MyCartScreenViewController.identifier) as? MyCartScreenViewController else {
            return
        }
        viewController.itemDetails = cartItems
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    private func calculateTotalCost(details: [CartItemDetails]) -> Int {
        totalCost =  0
        for items in details {
            let itemPrice = items.itemPrice
            let itemQuantity = items.itemQuantity
            totalCost += itemPrice * itemQuantity
        }
        return totalCost
    }
}

extension CartScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = cartItems else {
            return 0
        }
        return items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let items = cartItems else {
            return UICollectionViewCell()
        }
        if items.count == 0 {
            guard let emptyCartCell = cartItemCollectionView.dequeueReusableCell(
                withReuseIdentifier: NoCartItemsCollectionViewCell.identifier,
                for: indexPath
            ) as? NoCartItemsCollectionViewCell else {
                return UICollectionViewCell()
            }
            return emptyCartCell
        } else {
            guard let cartItemCell = cartItemCollectionView.dequeueReusableCell(
                withReuseIdentifier: CartItemCollectionViewCell.identifier,
                for: indexPath
            ) as? CartItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let items = cartItems else {
                return UICollectionViewCell()
            }
            cartItemCell.setupViewComponents(
                prodImage: items[indexPath.row].itemImage,
                prodName: items[indexPath.row].itemName,
                prodDescription: items[indexPath.row].itemSubDescription,
                prodPrice: String(items[indexPath.row].itemPrice),
                prodQuantity: String(items[indexPath.row].itemQuantity)
            )
            cartItemCell.delegate = self
            return cartItemCell
        }
    }
}

extension CartScreenViewController: UICollectionViewDelegate {
    
}

extension CartScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let items = cartItems else {
            return CGSize()
        }
        if items.count == 0 {
            return CGSize(
                width: collectionView.bounds.size.width,
                height: collectionView.bounds.height
            )
        } else {
            return CGSize(
                width: collectionView.bounds.size.width - 40,
                height: 110
            )
        }
    }
}

extension CartScreenViewController: CartItemCollectionViewCellDelegate {
    func quantityUpdated(productName: String, quantity: Int) {
        if let row = itemDetails.firstIndex(where: {$0.itemName == productName}) {
            itemDetails[row].itemQuantity = quantity
        }
        cartItems = itemDetails
        let cost = calculateTotalCost(details: itemDetails)
        totalPrice.text = "Rs. \(String(cost))"
    }
    
    func closeButtonTapped(productName: String) {
        if let row = itemDetails.firstIndex(where: {$0.itemName == productName}) {
            itemDetails.remove(at: row)
        }
        cartItems = itemDetails
        let cost = calculateTotalCost(details: itemDetails)
        totalPrice.text = "Rs. \(String(cost))"
        cartItemCollectionView.reloadData()
    }
}
