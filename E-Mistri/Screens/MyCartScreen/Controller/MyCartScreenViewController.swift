//
//  MyCartScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 27/01/2023.
//

import UIKit

class MyCartScreenViewController: UIViewController {
    
    @IBOutlet weak var goBackButton: CustomBackButton!
    @IBOutlet weak var myCartScreenTitle: UILabel!
    @IBOutlet weak var myCartCollectionView: UICollectionView!
    @IBOutlet weak var billDetailView: UIView!
    @IBOutlet weak var checkoutButton: CustomButton!
    @IBOutlet weak var billDetailText: UILabel!
    @IBOutlet weak var itemTotalText: UILabel!
    @IBOutlet weak var totalItems: UILabel!
    @IBOutlet weak var totalPriceText: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    static let identifier: String = "MyCartScreenViewController"
//    private let itemDetails: [CartItemDetails] = [
//        CartItemDetails(
//            itemImage: Images.brealkPad,
//            itemName: "FZ Break Pad",
//            itemSubDescription: "Amet minim mollit",
//            itemPrice: 1999,
//            itemQuantity: 1
//        ),
//        CartItemDetails(
//            itemImage: Images.engineFilter,
//            itemName: "FZ Air Filter",
//            itemSubDescription: "Amet minim mollit",
//            itemPrice: 1999,
//            itemQuantity: 4
//        ),
//        CartItemDetails(
//            itemImage: Images.gearBox,
//            itemName: "FZ Gear Box",
//            itemSubDescription: "Amet minim mollit",
//            itemPrice: 1999,
//            itemQuantity: 2
//        ),
//        CartItemDetails(
//            itemImage: Images.engineFilter,
//            itemName: "Duke Air Filter",
//            itemSubDescription: "Amet minim mollit",
//            itemPrice: 1999,
//            itemQuantity: 3
//        )
//    ]
    var itemDetails: [CartItemDetails]?
    private var totalItemNumber: Int = 0
    private var totalCost: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
        setupCollectionView()
    }
    
    private func viewComponents() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        view.backgroundColor = .productDetailBackgroundColor
        
        myCartScreenTitle.text = "My Cart"
        myCartScreenTitle.textAlignment = .center
        
        goBackButton.setupButton(buttonImage: Images.chevronBackward)
        goBackButton.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        
        billDetailView.layer.cornerRadius = 16.0
        billDetailView.layer.shadowOffset = CGSize(width: 2, height: 3)
        billDetailView.layer.shadowOpacity = 0.3
        billDetailView.layer.shadowRadius = 40.0
        billDetailView.clipsToBounds = false
        
        checkoutButton.setupButton(buttonTitle: "Proceed to Checkout")
        
        billDetailText.text = "Bill Detail"
        
        itemTotalText.text = "Item Total"
        itemTotalText.textColor = .detailPageGray
        
        guard let items = itemDetails else {
            return
        }
        let quantity = calculateTotalNumberOfItems(itemDet: items)
        totalItems.text = String(quantity)
        
        totalPriceText.text = "Total Price"
        
        let cost = calculateTotalCost(itemDet: items)
        totalPrice.text = "Rs. \(String(cost))"
    }
    
    private func setupCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 20
        myCartCollectionView.collectionViewLayout = flowLayout
        myCartCollectionView.backgroundColor = .productDetailBackgroundColor
        myCartCollectionView.delegate = self
        myCartCollectionView.dataSource = self
        myCartCollectionView.register(
            UINib(
                nibName: CartItemCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: CartItemCollectionViewCell.identifier
        )
        myCartCollectionView.register(
            UINib(
                nibName: AddSectionCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: AddSectionCollectionViewCell.identifier
        )
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func calculateTotalCost(itemDet: [CartItemDetails]) -> Int {
        totalCost =  0
        for items in itemDet {
            let itemPrice = items.itemPrice
            let itemQuantity = items.itemQuantity
            totalCost += itemPrice * itemQuantity
        }
        return totalCost
    }
    
    private func calculateTotalNumberOfItems(itemDet: [CartItemDetails]) -> Int {
        totalItemNumber = 0
        for items in itemDet {
            let itemQuantity = items.itemQuantity
            totalItemNumber += itemQuantity
        }
        return totalItemNumber
    }
}

extension MyCartScreenViewController: UICollectionViewDataSource {
    func numberOfSections(in tableView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            guard let items = itemDetails else {
                return 0
            }
            return items.count
        } else {
            return 1
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = indexPath.section
        if section == 0 {
            guard let cartItemCell = myCartCollectionView.dequeueReusableCell(
                withReuseIdentifier: CartItemCollectionViewCell.identifier,
                for: indexPath
            ) as? CartItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let items = itemDetails else {
                return UICollectionViewCell()
            }
            cartItemCell.setupViewComponents(
                prodImage: items[indexPath.row].itemImage,
                prodName: "\(items[indexPath.row].itemName) (x \(items[indexPath.row].itemQuantity))",
                prodDescription: items[indexPath.row].itemSubDescription,
                prodPrice: String(items[indexPath.row].itemPrice),
                prodQuantity: String(items[indexPath.row].itemQuantity)
            )
            cartItemCell.removeCellButton.isHidden = true
            cartItemCell.quantityView.isHidden = true
            return cartItemCell
        } else {
            guard let addItemCell = myCartCollectionView.dequeueReusableCell(
                withReuseIdentifier: AddSectionCollectionViewCell.identifier,
                for: indexPath
            ) as? AddSectionCollectionViewCell else {
                return UICollectionViewCell()
            }
            return addItemCell
        }
    }
}

extension MyCartScreenViewController: UICollectionViewDelegate {

}
extension MyCartScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            return CGSize(
                width: collectionView.bounds.size.width - 40,
                height: 110
            )
        } else {
            return CGSize(
                width: collectionView.bounds.size.width - 40,
                height: 260
            )
        }
    }
}
