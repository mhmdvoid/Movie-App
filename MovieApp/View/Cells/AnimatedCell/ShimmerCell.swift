//
//  ShimmerCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 18/12/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class ShimmerCell: BaseCell {
    
    let navTitleShimmer = ShimmerView(frame: .init(x: 10, y: 0, width: 110, height: 20))
    fileprivate func setupSubViews(_ numbers: [Int], _ i: Int) {
        let ii = ShimmerView(frame: .init(x: CGFloat(numbers[i]), y: 25, width: frame.width / 2, height: frame.height / 1.25))
        addSubviews(withViews: ii)
        ii.clipsToBounds = true
        ii.layer.cornerRadius = 7
        ii.startAnimating()
    }
    
    override func setupSubviews (){
        let numbers = [10, 220]
        addSubviews(withViews: navTitleShimmer)
        navTitleShimmer.clipsToBounds = true
        navTitleShimmer.layer.cornerRadius = 10
        navTitleShimmer.startAnimating()
        for i in 0..<2 {
            setupSubViews(numbers, i)
        }
    }
}
