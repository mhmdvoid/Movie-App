import UIKit

class Utilities {
    func activityButton(withTitle title: String, withImage image: UIImage) -> UIButton {
        let b = UIButton()
        b.setTitle(title, for: .normal)
        b.setTitleColor(.label, for: .normal)
        b.setImage(image, for: .normal)
        b.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return b
    }
}
