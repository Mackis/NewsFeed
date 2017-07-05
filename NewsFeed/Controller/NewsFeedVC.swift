//
//  NewsFeedVC.swift
//  NewsFeed
//
//  Created by Malcolm Kumwenda on 2017/07/05.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit

class NewsFeedVC: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.bounces = false
        return cv
    }()
    
    let articles: [Article] = {
        let a1 = Article(category: "Music", title: "Jay-Z release new 4:44 album", time_stamp: "10 min ago", summary: "this is the summary", body: "this is the body")
        return [a1, a1]
    }()
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "placer")
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupViews()
        
    }
    
    private func registerCells(){
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func setupViews(){
         // 1. Add all views
        view.backgroundColor = .red
        view.addSubview(backgroundImage)
        view.addSubview(collectionView)
        
        // 2. Setup constraints
        backgroundImage.fillSuperview()
        collectionView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 24, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 200)
    }
    
}

extension NewsFeedVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? NewsCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height)
    }
}

extension NewsFeedVC: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidthWithSpacing = layout.itemSize.width + layout.minimumLineSpacing
            var offSet = targetContentOffset.pointee
            let index = (offSet.x + scrollView.contentInset.left) / cellWidthWithSpacing
            let roundedIndex = round(index)
            let offSetX = roundedIndex * cellWidthWithSpacing - scrollView.contentInset.left
            let offSetY = -scrollView.contentInset.top
            offSet = CGPoint(x: offSetX, y: offSetY)
            targetContentOffset.pointee = offSet
        }
    }
}

