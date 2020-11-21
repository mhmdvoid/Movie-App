import UIKit

extension UIView {
    public func activateAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    
    func anchor(fromTop top: NSLayoutYAxisAnchor?, fromLeading leading: NSLayoutXAxisAnchor?, fromBottom bottom: NSLayoutYAxisAnchor?, fromTrailing trailing:
        NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        activateAutoLayout()
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
            
        }
    }
    
    func centerX(inView view: UIView, topAnchor top: NSLayoutYAxisAnchor?, paddingTop: CGFloat = 0) {
        
        activateAutoLayout()
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leadingAnchor leading: NSLayoutXAxisAnchor?, paddingLeading: CGFloat? = 0) {
        
        activateAutoLayout()
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading!).isActive = true
        }
    }
    
    func center(inView view: UIView, paddingTop top: CGFloat? = 0, paddingLeading leading: CGFloat? = 0) {
        
        activateAutoLayout()
        centerX(inView: view, topAnchor: nil)
        centerY(inView: view, leadingAnchor: nil)
    }
    
    func setDimension(width: CGFloat, height: CGFloat) {
        
        activateAutoLayout()
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width),
            self.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func addSubviews(withViews views: UIView...) {
        views.forEach { eachView in
            addSubview(eachView)
        }
    }
    
    
    func fillToEdge(in view: UIView, padding: UIEdgeInsets = .zero) {
        activateAutoLayout()
        [
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding.bottom),

        ].forEach { $0.isActive = true }
    }
    
}
