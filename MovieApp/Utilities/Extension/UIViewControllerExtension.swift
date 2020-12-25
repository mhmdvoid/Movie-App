//
//  UIViewControllerExtension.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 18/12/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class UIAnimatorController : UICollectionViewController {
    private var c = AnimatorList()
    
    
    var numberRows : Int {
        get { return c.rows }
        set {
            c.rows = newValue
        }
    }
    private var flag = true
    var isAnimatedLoading : Bool {
        get { return flag }
        set {
            if !newValue {
                hideAnimation()
            }
            flag = newValue
        }
    }
    init () {
        super.init(collectionViewLayout: FlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func startAnimating(customCell : UICollectionViewCell.Type) {
        addChild(c)
        view.addSubview(c.view)
        c.didMove(toParent: self)
        fillToEdege(yourView: c.view)
        c.prepareCustomCell(customCell, reuseIdentifier: "reuseIden")
        
    }
    
    private final func hideAnimation() {
        c.willMove(toParent: nil)
        c.view.removeFromSuperview()
        c.removeFromParent()
    }
    
    func fillToEdege(yourView: UIView) {
        yourView.translatesAutoresizingMaskIntoConstraints = false
        [
            yourView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            yourView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yourView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            yourView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ].forEach { $0.isActive = true }
    }
}




