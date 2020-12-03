//
//  MovieHeader.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 20/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieHeader: TableCell {
    
    override class var id: String {
        return "MovieCellHeader"
    }
    
    lazy var listButtons = [UIButton]()
    let circularProgress: CGFloat = 40
    
    private var geners: [Generis]? {
        didSet { setupLabels() }
    }
    
    var theMovie: MovieDetail? {
        didSet {
            if let movie = theMovie {
                geners = movie.genres
                showContent()
            }
            
            
        }
    }
    
    
    
    
    private let moviewImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
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
    
    
    private let movieDuration: UILabel  = {
        let text = UILabel()
        text.textColor = .label
        text.font = .systemFont(ofSize: 15, weight: .medium)
        return text
    }()
    override func setupSubviews() {
        
        setupCircularProgressBar()
        addSubviews(withViews: ratings, moviewImage, separator)
        ratings.anchor(fromTop: nil, fromLeading: insiderView.trailingAnchor, fromBottom: insiderView.bottomAnchor, fromTrailing: nil, padding: .init(top: 0, left: 4, bottom: -4, right: 0))
        moviewImage.anchor(fromTop: nil, fromLeading: leadingAnchor, fromBottom: bottomAnchor , fromTrailing: nil, padding: .init(top: 0, left: 5, bottom: -5, right: 0   ), size: .init(width: 150, height: 190))
        separator.anchor(fromTop: nil , fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor, size: .init(width: 0, height: 1))
        
        
        
        addSubview(movieDuration)
        movieDuration.anchor(fromTop: moviewImage.topAnchor, fromLeading: moviewImage.trailingAnchor, fromBottom: nil , fromTrailing: nil)
        
        
        setupHeader()
        setupCell()
    }
    
    
    func setupCell() {
        selectionStyle = .none
    }
    
    
    fileprivate func setupHeader() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    
    // setup the movie generes
    fileprivate func setupLabels() {
        guard let array = geners else { return }
        
        var colors: [UIColor] = [#colorLiteral(red: 0.7115528682, green: 0.4418075771, blue: 0.3254901961, alpha: 1), #colorLiteral(red: 1, green: 0.9113489454, blue: 0.3521985467, alpha: 1), #colorLiteral(red: 1, green: 0.2117647059, blue: 0.3254901961, alpha: 1), #colorLiteral(red: 0.2588235294, green: 0.5284139555, blue: 0.6980392157, alpha: 1), #colorLiteral(red: 0.3221586045, green: 0.367374786, blue: 0.2932363014, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.9521618151, green: 0.5236515411, blue: 0.8659032534, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
        
        colors.shuffle()
        var paddingTop: CGFloat = -30
        
        for i in 0..<array.count {
            let button = UIButton()
            
            button.backgroundColor = colors[i]
            button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
            
            button.setTitle("\(array[i].name)" , for: .normal)
            button.translatesAutoresizingMaskIntoConstraints  = false
            addSubview(button)
            
            button.setDimension(width: 93, height: 23)
            button.setTitleColor(UIColor(white: 0, alpha: 1), for: .normal)
            button.layer.cornerRadius = 3
            if i % 2 == 0 {
                paddingTop += 39
                button.anchor(fromTop: insiderView.bottomAnchor, fromLeading: moviewImage.trailingAnchor, fromBottom: nil , fromTrailing: nil, padding: .init(top: paddingTop, left: 0, bottom: 0, right: 0))
                continue
            }
            button.anchor(fromTop: insiderView.bottomAnchor, fromLeading: moviewImage.trailingAnchor, fromBottom: nil , fromTrailing: nil, padding: .init(top: paddingTop, left: 98, bottom: 0, right: 0))
            
        }
        
        
    }
    
    fileprivate func setupCircularProgressBar() {
        
        addSubview(insiderView)
        addSubview(scoreBreakdown)
        addSubview(cricularProgress)
        
        cricularProgress.progressColor = .systemRed
        cricularProgress.trackColor = .lightGray
        insiderView.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: nil , fromTrailing: nil, padding: .init(top: 25, left: 152, bottom: 0, right: 0) , size: .init(width: circularProgress, height: circularProgress))
        cricularProgress.fillToEdge(in: insiderView)
        scoreBreakdown.center(inView: insiderView)
        
        
    }
    
    func showContent() {
        guard let movie = theMovie else { return }
        let movieViewModel = MovieViewModel(movie: movie)
        
        
        cricularProgress.setProgressWithAnimation(duration: 1.5, value: Float(movie.vote_average / 10))
        ratings.text = movieViewModel.ratingsNumber
        scoreBreakdown.text = movieViewModel.scoreBreakdown
        
        guard let url = movieViewModel.moviePoster,
            let duration = movieViewModel.duration else { return }
        moviewImage.sd_setImage(with: url, completed: nil)
        
        movieDuration.text = duration
        
    }
}
