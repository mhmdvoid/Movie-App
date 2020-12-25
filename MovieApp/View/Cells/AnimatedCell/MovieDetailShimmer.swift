//
//  MovieDetailShimmer.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 25/12/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieDetailShimmer: UICollectionViewCell {
    
    
    lazy var movieInfo : ShimmerView = {
        let info = ShimmerView(frame : .init(x: 10, y: 0, width: self.frame.width - 20 , height: self.frame.height / 3))
        info.clipsToBounds = true
        info.layer.cornerRadius = 5
        return info
    }()
    lazy var movieOverviewShimmer = ShimmerView(frame: .init(x: 10, y: 300, width: self.frame.width - 20, height: self.frame.height / 8))
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(withViews: movieInfo, movieOverviewShimmer)
        movieInfo.startAnimating()
        movieOverviewShimmer.startAnimating()
        
        let numbers = [10, 105, 200, 295]
        
        for i in 0..<numbers.count {
            let castImage = ShimmerView(frame: .init(x: numbers[i], y: 430, width: 70, height: 70 ))
            addSubviews(withViews: castImage)
            castImage.clipsToBounds = true
            castImage.layer.cornerRadius = 70 / 2
            castImage.startAnimating()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
