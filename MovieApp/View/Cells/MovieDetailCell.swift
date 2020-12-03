//
//  RemovedCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 23/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieDetailCell: TableCell  {
    
    // MARK: Properties
    override class var id: String {
        return "CellDetailID"
    }
    var theMovie: MovieDetail? {
        didSet { showContent() }
    }
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.textColor = .label
        tv.isEditable = false
        return tv
    }()
    
    private let highRatedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemTeal
        button.setTitle("High rated", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        button.setDimension(width: 85, height: 20)
        button.layer.cornerRadius = 30
        button.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMinXMaxYCorner]
        return button
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .separator
        return separator
    }()
    
    fileprivate func setupCell() {
        backgroundColor = .systemBackground
    }
    
    override func setupSubviews() {
        addSubviews(withViews: textView, separator)
        textView.fillToEdge(in: self)
        separator.anchor(fromTop: nil , fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor, size: .init(width: 0, height: 1))
        setupCell()

    }
    fileprivate func showContent() {
        guard let movie = theMovie else { return }
        let movieViewModel = MovieViewModel(movie: movie)
        guard let overview = movieViewModel.movieOverview else { return }
        textView.attributedText = overview

        if movieViewModel.isHighRated {
            highRatedLabel()
        }
    }
    
    fileprivate func highRatedLabel() {
        addSubview(highRatedButton)
        highRatedButton.anchor(fromTop: topAnchor, fromLeading: nil , fromBottom: nil, fromTrailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 9 ))
    }
}
