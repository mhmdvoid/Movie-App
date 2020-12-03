//
//  CircularProgressBar.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 20/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class CircularProgressBar: UIView {
    let view2: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let progressLayer = CAShapeLayer(), trackLayer = CAShapeLayer()
  
    
    var progressColor = UIColor.white {
        didSet  {
            progressLayer.strokeColor = progressColor.cgColor
            
        }
    }
    
    var trackColor = UIColor.white {
        didSet  {
            trackLayer.strokeColor = trackColor.cgColor
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func createCircularPath() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.size.width / 2
        let circulePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.width - 1.5) / 2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
//        
        trackLayer.path = circulePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 4
        trackLayer.strokeEnd = 1
        trackLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(trackLayer)
    
        
        
        progressLayer.path = circulePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 4
        progressLayer.strokeEnd = 0 // this is the movable layer 1 means all the circular and 0.5 half of it
        progressLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(progressLayer)
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue   = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateprogress")
    }

}
