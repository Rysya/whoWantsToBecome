import UIKit

extension UITextField {
    convenience init(placeholder: String) {
        self.init(frame: CGRect())
        self.placeholder = placeholder
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        self.leftViewMode = .always
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4

        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
