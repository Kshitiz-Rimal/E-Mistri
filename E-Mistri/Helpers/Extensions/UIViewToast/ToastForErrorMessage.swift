//
//  ToastForErrorMessage.swift
//  E-Mistri
//
//  Created by gurzu on 14/02/2023.
//

import UIKit

extension UIViewController {
    func showErrorToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width / 2 - (view.frame.size.width - 40) / 2,
                                               y: 20,
                                               width: view.frame.size.width - 40, height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.numberOfLines = 2
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 2, options: .transitionFlipFromRight, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(_) in
            toastLabel.removeFromSuperview()
        })
    }
}
