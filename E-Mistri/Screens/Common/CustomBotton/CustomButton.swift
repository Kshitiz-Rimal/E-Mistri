//
//  CustomButton.swift
//  E-Mistri
//
//  Created by gurzu on 02/01/2023.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    func setupButton(buttonTitle: String) {
        setTitle(buttonTitle, for: .normal)
    }
    
    private func configureButton() {
        layer.shadowColor = UIColor.buttonShadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
        layer.cornerRadius = 4.0
        tintColor = .appPrimaryColor
    }
}
