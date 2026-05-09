import UIKit

extension UIStackView {
    
    convenience init(views: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat,
                     aligment: UIStackView.Alignment) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = aligment
    }
}

