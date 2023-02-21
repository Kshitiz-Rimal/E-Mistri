//
//  ErrorLabel.swift
//  E-Mistri
//
//  Created by gurzu on 06/01/2023.
//

import UIKit

class ErrorLabel: UILabel {
    override init(frame: CGRect) {
            super.init(frame: frame)
            viewComponents()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
           viewComponents()
        }
    
    func setupLabel(errorMessage: String) {
        text = errorMessage
    }
    
    private func viewComponents() {
        textColor = .systemRed
        isHidden = true
    }
}
