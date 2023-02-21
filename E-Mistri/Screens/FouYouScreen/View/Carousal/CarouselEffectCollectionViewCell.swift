//
//  CarouselEffectCollectionViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 17/01/2023.
//

import UIKit

class CarouselEffectCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CarouselEffectCollectionViewCell"
    
    @IBOutlet weak var carouselTitleText: UILabel!
    @IBOutlet weak var carouselImage: UIImageView!
    @IBOutlet weak var carouselBody: UIView!
    @IBOutlet weak var carouselSecondaryText: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    private func viewComponents() {
        carouselBody.layer.cornerRadius = 20.0
        let gradientView = CAGradientLayer()
        carouselBody.clipsToBounds = true
        gradientView.colors = [
            UIColor.black.cgColor,
            UIColor.gradientColorGreen.cgColor,
            UIColor.buyNowButtonGradColorOrange.cgColor,
            UIColor.white.cgColor
        ]
        gradientView.frame = .init(x: 0, y: 0, width: frame.width+10, height: frame.height+10)
        carouselBody.layer.insertSublayer(gradientView, at: 0)
        gradientView.startPoint = CGPoint(x: 0.4, y: 0.5)
        gradientView.endPoint = CGPoint(x: 1, y: 1)
        
        carouselTitleText.textColor = .carouselTitleTextColor
        
        carouselSecondaryText.textColor = .white
        carouselSecondaryText.numberOfLines = 2
        
        buyNowButton.setTitle(Text.buyNowBtnTitle, for: .normal)
        buyNowButton.layer.cornerRadius = 7.0
        buyNowButton.clipsToBounds = true
        let gradientButton = CAGradientLayer()
        gradientButton.colors = [
            UIColor.buyNowButtonGradColorOrange.cgColor,
            UIColor.buyNowButtonGradColorBlue.cgColor
        ]
        gradientButton.frame = buyNowButton.bounds
        buyNowButton.layer.insertSublayer(gradientButton, at: 0)
        gradientButton.startPoint = CGPoint(x: 0, y: 0.5)
        gradientButton.endPoint = CGPoint(x: 1, y: 0.5)
    }
}
