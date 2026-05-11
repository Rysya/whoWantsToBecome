import UIKit

extension UIButton {
    
    convenience init(text: String, tag: Int) {
        self.init(frame: .zero)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        self.setTitle(text, for: .normal)
        self.tag = tag
        self.backgroundColor = .systemCyan
        self.setTitleColor(.black, for: .normal)
        self.layer.masksToBounds = true
    }
    
    convenience init(icon: String) {
        self.init(frame: .zero)
        self.setImage(UIImage(systemName: icon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        self.backgroundColor = .systemCyan
        self.tintColor = .black
        self.layer.cornerRadius = 40
        self.layer.masksToBounds = true        
    }
}
