//
//  MovieHeader.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 20/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieHeader: UITableViewCell {
    
    static let headerCell = "headerCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupHeader()
    }
    
    lazy var listButtons = [UIButton]()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let circularProgress: CGFloat = 40
    var theMovie: MovieDetail? {
        didSet {
            
            showContent()
            
        }
    }
    
    var geners: [Generis]? {
        didSet { setupLabels() }
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
    func setupSubviews() {
        setupCircularProgressBar()
        addSubview(ratings)
        addSubview(moviewImage)
        ratings.anchor(fromTop: nil, fromLeading: insiderView.trailingAnchor, fromBottom: insiderView.bottomAnchor, fromTrailing: nil, padding: .init(top: 0, left: 4, bottom: -4, right: 0))
        moviewImage.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: nil , fromTrailing: nil, padding: .init(top: 20, left: 5, bottom: 0, right: 0   ), size: .init(width: 150, height: 190))
        addSubview(separator)
        separator.anchor(fromTop: nil , fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor, size: .init(width: 0, height: 1))
        
    }
    
    fileprivate func setupHeader() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }

    
    fileprivate func setupLabels() {
//        guard let geners = geners else { return }
//        print("Hello")
//        
////        lazy var listButton: [UIButton]
//        for i in 0..<geners.count {
//            // create buttons right here and append them to array
//            let eachButton = UIButton()
//            eachButton.setTitle(geners[i].name, for: .normal)
//            eachButton.titleLabel?.font = .systemFont(ofSize: 9)
//            eachButton.backgroundColor = .red
//            listButtons.append(eachButton)
//
//        }
//
//        let hStack = UIStackView(arrangedSubviews: listButtons)
//        addSubview(hStack)
//        hStack.distribution = .equalSpacing
//        hStack.axis = .horizontal
//        hStack.spacing = 20
//        print(listButtons)
//        hStack.anchor(fromTop: nil , fromLeading: moviewImage.trailingAnchor, fromBottom: self.bottomAnchor, fromTrailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10), size: .init(width: 0, height: 50))
        
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
