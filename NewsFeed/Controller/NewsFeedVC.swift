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
        return [a1, a1, a1, a1]
    }()
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "placer")
        return iv
    }()
    
    
    let tipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("MTIPPY!", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(showTip), for: .touchUpInside)
        return button
    }()
    
    let mTip: MTippy = {
        let tip = MTippy()
        return tip
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
        view.addSubview(tipButton)
        
        // 2. Setup constraints
        backgroundImage.fillSuperview()
        collectionView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 24, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 200)
        
        tipButton.anchorCenterSuperview()
    }
    
    @objc func showTip(){
        mTip.present(tip: "Hey this tip", direction: .up, toView: tipButton)
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
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height)
    }
}



