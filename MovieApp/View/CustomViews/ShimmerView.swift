//
//  ShimmerView.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 18/12/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class ShimmerView: UIView {
    
//    var gradientColorOne : CGColor = UIColor.opaqueSeparator.cgColor
//    var gradientColorTwo : CGColor = UIColor.lightGray.cgColor
    let gradientLayer = CAGradientLayer()
    let animation = CABasicAnimation(keyPath: "locations")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func startAnimating() {
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        rgba(0.24, 0.24, 0.26, 0.3)
        let colorDark = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.15)
        let colorDark2 = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.1)
        gradientLayer.colors = [colorDark2.cgColor, colorDark.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1]  // was 1
        self.layer.addSublayer(gradientLayer)
        animation.fromValue = [0.0, 0, 0.0]
        animation.toValue = [1, 3, 2.0]  // 1, 1.5, 2
        animation.repeatCount = .infinity
        animation.duration = 0.9
        gradientLayer.add(animation, forKey: animation.keyPath)
        
    }
    
    func stopAnimating() {
        gradientLayer.removeAnimation(forKey: animation.keyPath!)
    }
}
//[-1.0, -0.5, 0.0]
//[1.0, 2, 2.0]  // 1, 1.5, 2
