//
//  NowPlayingCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 15/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import SDWebImage
import UIKit

class AllMovieCell: BaseCell {
    
    // MARK: Properties
    static let movieCellId = "nowPlaying"
    var MovieSetCell: MovieResult? { didSet { showContent() }}
    
    let highlightColor = UIColor(white: 1, alpha: 0.3)
    var popupView: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 5
        return v
        
    }()
    override var isHighlighted: Bool {
        didSet { popupView.backgroundColor = isHighlighted ? highlightColor : .clear }
    }
    private let moviewImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        iv.sizeToFit()
        iv.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return iv
    }()
    private let imageLoader: UIActivityIndicatorView = {
           let ai = UIActivityIndicatorView(style: .large)
           ai.color = .label
           return ai
       }()
    
    
    override func setupSubviews() {
//        backgroundColor = .red
        addSubviews(withViews: moviewImage, popupView)
        popupView.fillToEdge(in: moviewImage)
        addSubview(imageLoader)
        imageLoader.startAnimating()
        moviewImage.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -15, right: 0))
        imageLoader.center(inView: moviewImage)
        
        
    }
    
    fileprivate func showContent( )  {
        // use MVVM
        guard let movieResultSet = MovieSetCell else { return }
        guard let moviePost = movieResultSet.poster_path else { return }
        let formattedUrl = "https://image.tmdb.org/t/p/\(IMAGE_QUALITY)\(moviePost)"
        guard let url = URL(string: formattedUrl) else { return }
        
        self.moviewImage.sd_setImage(with: url) { (image, e, cache, url) in
            self.imageLoader.stopAnimating()
            self.imageLoader.hidesWhenStopped = true
        }
    
    }
    
    //"https://image.tmdb.org/t/p/w500/pci1ArYW7oJ2eyTo2NMYEKHHiCP.jpg"
    
}

