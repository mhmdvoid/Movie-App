//
//  MovieHeader.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 20/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieHeader: BaseReusableViews {
    
    let circularProgress: CGFloat = 40
    static let headerCell = "headerCell"
    var theMovie: MovieDetail? {
        didSet {
            print("FG")
            showContent()
            
        }
    }
    
    private let moviewImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
//        iv.layer.masksToBounds = true
//        iv.sizeToFit()
//        iv.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return iv
    }()
    //circularProfress
    private lazy var cricularProgress = CircularProgressBar(frame: CGRect(x: 0, y: 0, width: circularProgress, height: circularProgress))
    
    
    let insiderView: UIView = {
        let v = UIView( )
        v.isHidden = true
        return v
    }()
    
    private let ratings: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private let scoreBreakdown: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .separator
        return separator
    }()
    override func setupSubviews() {
        setupHeader()
        setupCircularProgressBar()
        addSubview(ratings)
        addSubview(moviewImage)
        ratings.anchor(fromTop: nil, fromLeading: insiderView.trailingAnchor, fromBottom: insiderView.bottomAnchor, fromTrailing: nil, padding: .init(top: 0, left: 4, bottom: -4, right: 0))
        moviewImage.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: nil , fromTrailing: nil, padding: .init(top: 20, left: 5, bottom: 0, right: 0   ), size: .init(width: 150, height: 190))
        addSubview(separator)
        separator.anchor(fromTop: nil , fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor, size: .init(width: 0, height: 1))
        
    }
    
    fileprivate func setupHeader() {
//        backgroundColor = UIColor(white: 0, alpha: 0.2)
        backgroundColor = .systemBackground
//        layer.borderWidth = 3
//        layer.cornerRadius = 5
//        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    fileprivate func setupCircularProgressBar() {
        addSubview(insiderView)
        addSubview(scoreBreakdown)
        addSubview(cricularProgress)
        cricularProgress.progressColor = .systemRed
        cricularProgress.trackColor = .lightGray
        insiderView.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: nil , fromTrailing: nil, padding: .init(top: 80, left: 152, bottom: 0, right: 0) , size: .init(width: circularProgress, height: circularProgress))
        cricularProgress.fillToEdge(in: insiderView)
        scoreBreakdown.center(inView: insiderView)
        
    }
    
    func showContent() {
        
        if let movie = theMovie {
            let movieViewModel = MovieViewModel(movie: movie)
            cricularProgress.setProgressWithAnimation(duration: 1.5, value: Float(movie.vote_average / 10))
            ratings.text = movieViewModel.ratingsNumber
            scoreBreakdown.text = movieViewModel.scoreBreakdown
            if let url = movieViewModel.moviePoster {
                moviewImage.sd_setImage(with: url, completed: nil)
            }
        }
        
        // MVVM
    }
}
