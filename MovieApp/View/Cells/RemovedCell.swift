//
//  RemovedCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 23/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    static let movieCellId = "movieCell"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(textView)
        textView.fillToEdge(in: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func showContent() {
           guard let movie = theMovie else { return }
           let movieViewModel = MovieViewModel(movie: movie)
           if let overview = movieViewModel.movieOverview {
               textView.attributedText = overview
           }
       }
    
}
