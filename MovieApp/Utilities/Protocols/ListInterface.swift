//
//  ListInterface.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 18/12/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit
protocol CustomCell {
    func prepareCustomCell(_ cell : UICollectionViewCell.Type, reuseIdentifier : String )
}

protocol CollectionList :  UICollectionViewController , CustomCell{
    
}
