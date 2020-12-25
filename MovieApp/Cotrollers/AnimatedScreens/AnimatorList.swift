//
//  ViewController2.swift
//  MovieApp
//
//  Created by Mohammed mohsen on 17/12/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//
import UIKit

//private let reuseIdentifier = "Cell"

class AnimatorList : UICollectionViewController, CollectionList {
    
    var rows = 3
    var height: CGFloat = 300
    private var reuse = ""
    init () {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = false
    }
    
    func prepareCustomCell(_ cell: UICollectionViewCell.Type, reuseIdentifier: String) {
        reuse = reuseIdentifier
        collectionView.register(cell , forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath)
        cell.backgroundColor = .systemBackground
        return cell
    }
}

extension AnimatorList : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width
            , height: height)   // use dynamic height here pleas 
    }
}

//class ShimmerView2: UICollectionViewCell {
//
//
//    var didFinish : Bool? {
//        didSet {
//            if didFinish != nil {
//                print("I WAS SET")
//                self.views.forEach {
//                    $0.stopAnimating()
//
//                }
////                // Async always always mean i am gonna take time 'could be specified' and i'll go down to execute other instraction
////                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
////                    guard let self = self else { return }
////                    self.views.forEach {
////                        $0.stopAnimating()
////                        $0.isHidden = true
////                    }
////                    self.addSubview(self.textLLabel)
////                    self.textLLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
////                    self.textLLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
////                    self.textLLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
////                    self.textLLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
////                    self.textLLabel.text = "KKLKLKLKL"
////                }
//            }
//        }
//    }
//
//    private let textLLabel : UILabel = {
//        let la = UILabel()
//        la.translatesAutoresizingMaskIntoConstraints = false
//        return la
//    }()
//    lazy var textName = ShimmerView(frame: .init(x: 75, y: 45, width: (self.frame.width - 99), height: 25))
//    lazy var profileImage: ShimmerView = {
//        let iv = ShimmerView(frame: .init(x: 10, y: 16, width: 55, height: 55))
//        iv.clipsToBounds = true
//        iv.layer.cornerRadius = 55 / 2
//        return iv
//    }()
//
//    lazy var bigView: ShimmerView = {
//        let iv = ShimmerView(frame: .init(x: 10, y: 80, width: (self.frame.width - 25), height: self.frame.height - 130))
//        // other custom code goes here
//        return iv
//    }()
//
//    lazy var views = [profileImage, bigView, textName]
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        views.forEach({
//            addSubview($0)
//            $0.startAnimating()
//        })
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}


