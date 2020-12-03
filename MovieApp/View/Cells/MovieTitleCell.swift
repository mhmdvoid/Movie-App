//
//  MovieTitleCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 29/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieTitleCell: TableCell {
    
    override class var id: String {
        return "MovieTitleID"
    }
    var theMovie: MovieDetail? {
        didSet {
            
            showContent()
            
        }
    }
    private let movieName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.font = .systemFont(ofSize: 16)
        return name
    }()

    
    override func setupSubviews() {
        selectionStyle = .none
        addSubview(movieName)
        movieName.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 0))
    }
    
    
    fileprivate func showContent() {
        guard let movie = theMovie else { return }
        movieName.text = movie.title
        
    }
}
