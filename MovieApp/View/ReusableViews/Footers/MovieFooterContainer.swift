//
//  MovieFooterContainer.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 26/11/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//


// Refactor ?
import UIKit

class MovieFooterContainer: TableCell {
    
    
    override class var id: String {
        return "footerIdCell"
    }
    var whichRow: Int?
    
    var sectionTitle: FooterTitleSection? {
        didSet {
            if let title = sectionTitle {
                
                footerLabel.text = title.description
                
            }
        }
    }
    
    var dataSource = [Any]() {
        didSet { collectionView.reloadData() }
    }
    let collectionView: UICollectionView = {
        let layout = FlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    let footerLabel: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 18, weight: .medium)
        return title
    }()
    
    
    override func setupSubviews() {
        
        
        addSubviews(withViews: collectionView, footerLabel)
        
        
        collectionView.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: bottomAnchor, fromTrailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        footerLabel.anchor(fromTop: topAnchor, fromLeading: leadingAnchor, fromBottom: nil , fromTrailing: nil, padding: .init(top: 7, left: 5, bottom: 0, right: 0))
        
        setupCollectionview()
        setupCell()

    }
    
    func setupCell() {
        selectionStyle = .none
    }
    fileprivate func setupCollectionview() {
        
        collectionView.register(CastCell.self , forCellWithReuseIdentifier: "cast")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
}

extension MovieFooterContainer: CollectionViewMethods {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return whichRow == 3 ? dataSource.count : dataSource.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if whichRow == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cast", for: indexPath) as! CastCell
            cell.eachCast = dataSource[indexPath.row] as? Cast
            cell.layer.cornerRadius = 100 / 2
            cell.clipsToBounds = true
            return cell
        }
        collectionView.isPagingEnabled = true
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cast", for: indexPath) as! CastCell
        cell.MovieSetCell = dataSource[indexPath.row] as? MovieResult
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return whichRow == 3 ? 10 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return whichRow == 3 ? .init(width: 100, height: 100) : .init(width: collectionView.frame.width / 3 , height: 170)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return whichRow == 3 ? .init(top: 0, left: 5, bottom: 0, right: 5) : .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let movieVC = MovieVC(theMovieId: dataSour.id, backButtonTitle: "backButtonString")
    }
    
}
