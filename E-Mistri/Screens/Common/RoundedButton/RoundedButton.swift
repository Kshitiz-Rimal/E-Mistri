import UIKit

class RoundedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    func configureButton() {
        layer.cornerRadius = 0.5 * bounds.size.width
        clipsToBounds = true
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        setImage(UIImage(systemName: Images.chevronForward, withConfiguration: boldConfig), for: .normal)
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.appPrimaryColor.cgColor,
            UIColor.white.cgColor
        ]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        gradient.startPoint = CGPoint(x: 0.3, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        setImage(UIImage(systemName: Images.RoundedButtonImage, withConfiguration: boldConfig), for: .normal)
    }
}
