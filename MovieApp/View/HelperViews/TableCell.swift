//
//  TableCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 03/12/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    class var id: String {
        return "BaseId"
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupSubviews() {
        
    }
}
