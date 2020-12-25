//
//  HomeList.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 13/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//
import UIKit

private let reuseIdentifier = "Cell"

class HomeList: UIAnimatorController {
    
    lazy var refereshControl: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self , action: #selector(refresh), for: .valueChanged)
        r.tintColor = .systemRed
        return r
    }()
    
    deinit {
        print("Controller deallocated")
    }
    // MARK: Properties
    var playingNowMovies = [MovieResult]()
    var topRatedMovies = [MovieResult]()
    var upcomingMovies = [MovieResult]()
    var popularMovies = [MovieResult]()
    
    // MARK: Constructor
  
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimating(customCell: ShimmerCell.self)
        setupCollectionView()
        fetch()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        setNavBar()
    }
    
    // MARK: API
    fileprivate func fetch() {
        let dispatchGroup = DispatchGroup()
        
        let endpoints: [APIEndpoint] = [.nowPlaying, .popular, .topRated, .upcoming]
        for endpoint in endpoints {
            dispatchGroup.enter()
            MovieService.shared.fetchMovies(with: endpoint) { [weak self] result in  // Perfect
                guard let this = self else { return }
                switch result {
                case .success(let movieRest):
                    switch endpoint {
                    case .nowPlaying:
                        
                        this.playingNowMovies = movieRest.results
                    case .popular:
                        
                        this.popularMovies = movieRest.results
                    case .topRated:
                        
                        this.topRatedMovies = movieRest.results
                    case .upcoming:
                        
                        this.upcomingMovies = movieRest.results
                    }
                    dispatchGroup.leave()

                case .failure(let e):
                    print(e.localizedDescription)
                }
                
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in // To notify ourselves when multiple different tasks are finished
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                print("I took time & went down to other threads")
                self.isAnimatedLoading = false
                self.navigationItem.title = "Movie"
            }
            print("i have asynced the code takes time and am executing this code here till the result got back from the code takes time")
            self.collectionView.reloadData()
            
        }
    }
    
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.fetch()
            refreshControl.endRefreshing()
        }
        
    }
    // MARK: Helpers
    fileprivate func setupCollectionView() {
        collectionView.refreshControl = refereshControl
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCellContainer.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    fileprivate func setNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return APIEndpoint.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cellHeader = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCellContainer
            cellHeader.whichRow = indexPath.row
            cellHeader.headerTitle = APIEndpoint(rawValue: indexPath.row)
            cellHeader.moviesSet = popularMovies
            cellHeader.delegate = self
            return cellHeader
        case 1:
            let nowPlayingcell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  MovieCellContainer
            nowPlayingcell.headerTitle = APIEndpoint(rawValue: indexPath.row)
            nowPlayingcell.whichRow = indexPath.row
            nowPlayingcell.moviesSet = playingNowMovies
            nowPlayingcell.delegate = self
            return nowPlayingcell
        case 2:
            let topRatedCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  MovieCellContainer
            topRatedCell.headerTitle = APIEndpoint(rawValue: indexPath.row)
            topRatedCell.whichRow = indexPath.row
            topRatedCell.moviesSet = topRatedMovies
            topRatedCell.delegate = self
            return topRatedCell
        case 3:
            let upcomingCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  MovieCellContainer
            upcomingCell.headerTitle = APIEndpoint(rawValue: indexPath.row)
            
            upcomingCell.whichRow = indexPath.row
            upcomingCell.delegate = self
            upcomingCell.moviesSet = upcomingMovies
            return upcomingCell
        default :
            return .init(frame: .zero)
            
        }
        
    }
    
    
}

extension HomeList: UICollectionViewDelegateFlowLayout, MovieCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.row == 0 ? CGSize(width: view.frame.width, height: 370) : CGSize(width: view.frame.width, height: 200)
        
    }
    func movieCellDidTap(_ withMovie: MovieResult, _ backBtnTitle: String?) {
        guard let backButtonString = backBtnTitle else { return }
        let movieVC = MovieVC(service: MovieService(), movieId: withMovie.id, backButtonTitle: backButtonString)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}
