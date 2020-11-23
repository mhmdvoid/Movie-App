//
//  HomeList.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 13/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//
import UIKit

private let reuseIdentifier = "Cell"

class HomeList: UICollectionViewController {
    
    // MARK: Properties
    
    
    // MARK: Constructor
    init() {
        let layout = FlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("List DID LOAD")
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        print("WILL LOAD")
        setNavBar()
    }
    
    // MARK: Helpers
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCellContainer.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    // MARK: API
    
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
            cellHeader.delegate = self
            return cellHeader
        case 1:
            let nowPlayingcell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  MovieCellContainer
            nowPlayingcell.headerTitle = APIEndpoint(rawValue: indexPath.row)
            nowPlayingcell.whichRow = indexPath.row
            nowPlayingcell.delegate = self
            return nowPlayingcell
        case 2:
            let topRatedCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  MovieCellContainer
            topRatedCell.headerTitle = APIEndpoint(rawValue: indexPath.row)
            topRatedCell.whichRow = indexPath.row
            topRatedCell.delegate = self
            return topRatedCell
        case 3:
            let upcomingCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  MovieCellContainer
            upcomingCell.headerTitle = APIEndpoint(rawValue: indexPath.row)
            print(indexPath.row)
            upcomingCell.whichRow = indexPath.row
            upcomingCell.delegate = self
            
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
        let movieVC = MovieVC(theMovieId: withMovie.id, backButtonTitle: backButtonString)
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    
    
    
}
