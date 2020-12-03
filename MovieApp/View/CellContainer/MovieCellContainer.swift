//
//  MovieCell.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 14/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit
protocol MovieCellDelegate: class {
    func movieCellDidTap(_ withMovie: MovieResult, _ backBtnTitle: String?)
}
class MovieCellContainer: BaseCell {
    
    
    // MARK: Properties
    weak var delegate: MovieCellDelegate?
    var whichRow: Int?

    var moviesSet = [MovieResult]() {
        didSet {
            self.collectionView.reloadData()
        }
    }

    
    private let holderView = UIView()
    
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
    

    
    // MARK: Helpers
    override func setupSubviews() {
//        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
////        window.addSubview(activityIndicator)
//        window.addSubview(holderView)
//        holderView.setDimension(width: 50, height: 50)
//        holderView.backgroundColor = .systemRed
//        holderView.center = window.center
//        holderView.addSubview(activityIndicator)
//        activityIndicator.center = holderView.center
//        activityIndicator.startAnimating()
//        fetch()
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
            let string = headerTitle?.headerTitle
            let popularMovie = moviesSet[indexPath.row]
            delegate?.movieCellDidTap(popularMovie, string)
        case 1:
            let string = headerTitle?.headerTitle

            let nowPlayingMovie = moviesSet[indexPath.row]
            delegate?.movieCellDidTap(nowPlayingMovie, string)
        case 2:
            let string = headerTitle?.headerTitle

            let topRated = moviesSet[indexPath.row]
            delegate?.movieCellDidTap(topRated, string)
        case 3:
            let string = headerTitle?.headerTitle

            let upComing = moviesSet[indexPath.row]
            delegate?.movieCellDidTap(upComing, string)
        default:
            return
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let whichCell = whichRow else {return 0}
        
        switch whichCell {
        case 0:
            return moviesSet.count
        case 1:
            return moviesSet.count
        case 2:
            return moviesSet.count
        case 3:
            return moviesSet.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch whichRow {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMovieCell.movieCellId, for: indexPath) as! AllMovieCell
            cell.MovieSetCell = moviesSet[indexPath.row]
            return cell
        case 1:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMovieCell.movieCellId, for: indexPath) as! AllMovieCell
            cell.MovieSetCell = moviesSet[indexPath.row]
            return cell
        case 2:
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMovieCell.movieCellId, for: indexPath) as! AllMovieCell
            cell.MovieSetCell = moviesSet[indexPath.row]
            return cell
        case 3:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllMovieCell.movieCellId, for: indexPath) as! AllMovieCell
            cell.MovieSetCell = moviesSet[indexPath.row]
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
