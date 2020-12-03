//
//  CastCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 26/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class CastCell: BaseCell {
    // MARK: Properties
    static let castCellId = "castID"
    
    private let castImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var eachCast: Cast? {
        didSet {
            showContent()
        }
    }
    
    var MovieSetCell: MovieResult? { didSet { showContent2() }}

    
    override func setupSubviews() {
        
        addSubview(castImage)
        castImage.fillToEdge(in: self)
        
    }
    
    fileprivate func showContent(){
        if let cast = eachCast {
            guard let imageString = cast.profile_path else { return }
            let formattedUrl = "https://image.tmdb.org/t/p/w500/\(imageString)"
            MovieService.shared.downloadCachedImage(fromUrl: formattedUrl) { theImage  in
                DispatchQueue.main.async {
                    self.castImage.image = theImage
                }
                
            }
        }
    }
    
    fileprivate func showContent2( )  {
        // use MVVM
        guard let movieResultSet = MovieSetCell else { return }
        guard let moviePost = movieResultSet.poster_path else { return }
        let formattedUrl = "https://image.tmdb.org/t/p/\(IMAGE_QUALITY)\(moviePost)"
        guard let url = URL(string: formattedUrl) else { return }
        castImage.contentMode = .scaleAspectFit
        self.castImage.sd_setImage(with: url) { (image, e, cache, url) in
//            self.imageLoader.stopAnimating()
//            self.imageLoader.hidesWhenStopped = true
        }
    
    }
}
