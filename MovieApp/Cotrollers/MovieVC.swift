//
//  MovieVC.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 20/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit

class MovieVC: UICollectionViewController {
    
    
    let theMovieId: Int
    let backButtonString: String
    var theMovie: MovieDetail? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = .label
        return ai
    }()
    init(theMovieId: Int, backButtonTitle: String) {
        self.theMovieId = theMovieId
        self.backButtonString = backButtonTitle
        let layout = FlowLayout()
        
        super.init(collectionViewLayout: layout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        activityIndicator.center(inView: view)
        activityIndicator.startAnimating()
        navigationItem.title = "Detail"
        
        let backButton = UIBarButtonItem()
        backButton.title = backButtonString
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieDetailCell.self , forCellWithReuseIdentifier: "movieDetail")
        collectionView.register(MovieHeader.self , forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieHeader.headerCell)
        collectionView.register(UICollectionReusableView.self , forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        print("ID: ", theMovieId)
        
        MovieService.shared.fetchMovie(withId: theMovieId) { (result) in
            switch result {
            case .success(let theMovie):
                self.theMovie = theMovie
            //                self.movieGener = theMovie.genres;
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieDetail", for: indexPath) as! MovieDetailCell
        cell.backgroundColor = .systemBackground
        cell.theMovie = theMovie
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieHeader.headerCell, for: indexPath) as! MovieHeader
            headerView.theMovie = theMovie
            //
            //            headerView.backgroundColor = .systemBackground
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            
            footerView.backgroundColor = .systemGreen
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
}

extension MovieVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let theMovie = theMovie else {
            return .zero
        }
        let viewModel = MovieViewModel(movie: theMovie)
        let height = viewModel.size(forWidth: view.frame.width).height
        // was 42
        
        // i could've used the Overview here that will be way better i will tesr
        return CGSize(width: view.frame.width, height: height + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}
