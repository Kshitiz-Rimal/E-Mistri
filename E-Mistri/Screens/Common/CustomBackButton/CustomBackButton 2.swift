//
//  CustomBackButton.swift
//  E-Mistri
//
//  Created by gurzu on 23/01/2023.
//

import UIKit

class CustomBackButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    func setupButton(buttonImage: String) {
        if buttonImage == Images.heartFill {
            setImage(UIImage(systemName: buttonImage), for: .selected)
        } else {
            setImage(UIImage(systemName: buttonImage), for: .normal)
        }
    }
    
    private func configureButton() {
        setTitle("", for: .normal)
        backgroundColor = .white
        tintColor = .accountScreenChevronBlue
        setTitle("", for: .normal)
        layer.cornerRadius = 8.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.03
        layer.masksToBounds = false
    }
}
