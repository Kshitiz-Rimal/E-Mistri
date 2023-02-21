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
    let itemDetails: [CartItemDetails] = [
        CartItemDetails(
            itemImage: Images.brealkPad,
            itemName: "FZ Break Pad",
            itemSubDescription: "Amet minim mollit",
            itemPrice: "1999",
            itemQuantity: "1"
        ),
        CartItemDetails(
            itemImage: Images.engineFilter,
            itemName: "FZ Air Filter",
            itemSubDescription: "Amet minim mollit",
            itemPrice: "1999",
            itemQuantity: "4"
        ),
        CartItemDetails(
            itemImage: Images.gearBox,
            itemName: "FZ Gear Box",
            itemSubDescription: "Amet minim mollit",
            itemPrice: "1999",
            itemQuantity: "2"
        ),
        CartItemDetails(
            itemImage: Images.engineFilter,
            itemName: "Duke Air Filter",
            itemSubDescription: "Amet minim mollit",
            itemPrice: "1999",
            itemQuantity: "3"
        )
    ]
    var totalItemNumber: Int = 0
    var totalCost: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
        self.view.backgroundColor = .productDetailBackgroundColor
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
    
    private func viewComponents() {
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
        
        totalPriceText.text = "Total Price"
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension MyCartScreenViewController: UICollectionViewDataSource {
    func numberOfSections(in tableView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return itemDetails.count
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
            let quantityNumber = cartItemCell.setupViewComponents(
                prodImage: itemDetails[indexPath.row].itemImage,
                prodName: "\(itemDetails[indexPath.row].itemName) (x \(itemDetails[indexPath.row].itemQuantity))",
                prodDescription: itemDetails[indexPath.row].itemSubDescription,
                prodPrice: itemDetails[indexPath.row].itemPrice,
                prodQuantity: itemDetails[indexPath.row].itemQuantity
            )
            guard let itemPrice = Int(itemDetails[indexPath.row].itemPrice) else {
                return UICollectionViewCell()
            }
            guard let itemQuantity = Int(itemDetails[indexPath.row].itemQuantity) else {
                return UICollectionViewCell()
            }
            totalCost += itemPrice * itemQuantity
            totalPrice.text = "Rs. \(String(totalCost))"
            totalItemNumber += itemQuantity
            totalItems.text = String(totalItemNumber)
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
