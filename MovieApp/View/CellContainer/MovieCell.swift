//
//  MovieCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 14/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit
protocol MovieCellDelegate: class {
    func movieCellDidTap(_ withMovie: MovieResult)
}
class MovieCellContainer: BaseCell {
    
    
    // MARK: Properties
    weak var delegate: MovieCellDelegate?
    var whichRow: Int?
    var playingNowMovies = [MovieResult]() 
    var topRatedMovies = [MovieResult]()
    var upcomingMovies = [MovieResult]()
    var popularMovies = [MovieResult]()
    
    let topSpace: CGFloat = 30
    var headerTitle: APIEndpoint? {
        didSet {
            if let title = headerTitle {
                sectionTitle.text = title.headerTitle
                
            }
        }
    }
    private let sectionTitle: UILabel =  {
        let sec = UILabel()
        sec.font = .systemFont(ofSize: 17, weight: .medium)
        sec.textColor = .label
        return sec
    }()
    private let collectionView: UICollectionView =  {
        let layout = FlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout )
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    // MARK: API
    fileprivate func fetch() {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        MovieService.shared.fetchMovies(with: .nowPlaying) { (res) in
            switch res {
            case .success(let movieRest):
                self.playingNowMovies = movieRest.results
            case .failure(let e ):
                print(e.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        MovieService.shared.fetchMovies(with: .topRated) { (res) in
            switch res {
            case .success(let movieRest):
                self.topRatedMovies = movieRest.results
            case .failure(let e ):
                print(e.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        MovieService.shared.fetchMovies(with: .upcoming) { (res) in
            switch res {
            case .success(let movieRest):
                self.upcomingMovies = movieRest.results
            case .failure(let e ):
                print(e.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        MovieService.shared.fetchMovies(with: .popular) { (res) in
            switch res {
            case .success(let movieRest):
                self.popularMovies = movieRest.results
            case .failure(let e ):
                print(e.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .main) { [weak self] in // To notify ourselves when multiple different tasks are finished
            guard let self = self else { return }
            self.collectionView.reloadData()
            
        }
    }
    
    // MARK: Helpers
    override func setupSubviews() {
        fetch()
        addSubviews(withViews: collectionView, sectionTitle)
        setupCollectionView()
        sectionTitle.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: nil, fromTrailing: trailingAnchor,
                            padding: .init(top: 0, left: 5, bottom: 0, right: 0))
    }
    
    fileprivate func setupCollectionView() {
        collectionView.fillToEdge(in: self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AllMovieCell.self , forCellWithReuseIdentifier: AllMovieCell.movieCellId)
        

    }
}






extension MovieCellContainer: CollectionViewMethods {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch whichRow {
        case 0:
            print("SFDg")
            let popularMovie = popularMovies[indexPath.row]
            delegate?.movieCellDidTap(popularMovie)
        case 1:
            let nowPlayingMovie = playingNowMovies[indexPath.row]
            delegate?.movieCellDidTap(nowPlayingMovie)
        case 2:
            let topRated = topRatedMovies[indexPath.row]
            delegate?.movieCellDidTap(topRated)
        case 3:
            let upComing = upcomingMovies[indexPath.row]
            delegate?.movieCellDidTap(upComing)
        default:
            print("Error")
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let whichCell = whichRow else {return 0}
        
        switch whichCell {
        case 0:
            return popularMovies.count
        case 1:
            return playingNowMovies.count
        case 2:
            return topRatedMovies.count
        case 3:
            return upcomingMovies.count
            
        default:
            print("Reaylly")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch whichRow {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMovieCell.movieCellId, for: indexPath) as! AllMovieCell
            cell.MovieSetCell = popularMovies[indexPath.row]
            return cell
        case 1:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMovieCell.movieCellId, for: indexPath) as! AllMovieCell
            cell.MovieSetCell = playingNowMovies[indexPath.row]
            return cell
        case 2:
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMovieCell.movieCellId, for: indexPath) as! AllMovieCell
            cell.MovieSetCell = topRatedMovies[indexPath.row]
            return cell
        case 3:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMovieCell.movieCellId, for: indexPath) as! AllMovieCell
            cell.MovieSetCell = upcomingMovies[indexPath.row]
            return cell
            
        default :
            return .init(frame: .zero)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 1.5 , height: frame.height - topSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topSpace, left: 5, bottom: 0, right: 5)
    }
    
    
}
