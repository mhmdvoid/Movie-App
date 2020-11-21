////
////  RemovedCollectionViewController.swift
////  MovieApp
////
////  Created by Mohammed mohsen on 20/11/2020.
////  Copyright © 2020 Mohammed mohsen. All rights reserved.
////
//
//import UIKit
//
//private let reuseIdentifier = "Cell"
//
//class RemovedCollectionViewController: ViewController {
//
//  
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        collectionView.backgroundColor = .systemBackground
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
//        self.collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 20
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        cell.backgroundColor = .red
//        return cell
//    }
//
//    
//
//}
//
//extension RemovedCollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width / 2.5 , height: collectionView.frame.width / 2)
//    }
//}
