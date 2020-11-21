//
//  BaseReusableViews.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 14/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class BaseReusableViews: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    func setupSubviews() {
    }
}
