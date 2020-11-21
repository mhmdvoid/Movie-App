//
//  MovieDetailCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 21/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieDetailCell: BaseCell {
    var theMovie: MovieDetail? {
        didSet { showContent() }
    }
    private let textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    override func setupSubviews() {
        addSubview(textView)
        addSubview(overviewLabel)
        textView.anchor(fromTop: overviewLabel.bottomAnchor, fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor)
        overviewLabel.anchor(fromTop: topAnchor, fromLeading: textView.leadingAnchor, fromBottom: nil , fromTrailing: nil , padding: .init(top: 2, left: 3, bottom: 0, right: 0))
    }
    
    fileprivate func showContent() {
        guard let movie = theMovie else { return }
        let movieViewModel = MovieViewModel(movie: movie)
        if let overview = movie.overview {
            textView.text = overview
        }
    }
    
}
