//
//  NowPlayingCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 15/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class AllMovieCell: BaseCell {
    
    // MARK: Properties
    
    static let movieCellId = "nowPlaying"
    var playingNowMovie: MovieResult? {
        didSet { showContent() }
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
    
    
    override func setupSubviews() {
        setupCell()
        addSubview(moviewImage)
        moviewImage.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -10, right: 0))
    }
    
    fileprivate func setupCell() {
        
    }
    
    
    fileprivate func showContent( )  {
        guard let playingMovies = playingNowMovie else { return }
        guard let moviePost = playingMovies.poster_path else { return }
        let formattedUrl = "https://image.tmdb.org/t/p/original\(moviePost)"
        
        MovieService.shared.downloadCachedImage(fromUrl: formattedUrl) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.moviewImage.image = image
                
            }
        }
        //
        
        
    }
    
    
    
    //"https://image.tmdb.org/t/p/w500/pci1ArYW7oJ2eyTo2NMYEKHHiCP.jpg"
    
}
