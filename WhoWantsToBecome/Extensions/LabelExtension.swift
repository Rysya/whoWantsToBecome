import UIKit

extension UILabel {
    
    convenience init(text: String, size: CGFloat, weight: UIFont.Weight) {
        self.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.backgroundColor = .clear
        self.textColor = .black
        self.textAlignment = .center
        self.numberOfLines = 0
    }
}
