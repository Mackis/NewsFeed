//
//  NewsCell.swift
//  NewsFeed
//
//  Created by Malcolm Kumwenda on 2017/07/05.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import BonMot

class NewsCell: UICollectionViewCell {
    var article: Article? {
        didSet {
            self.updateUI()
        }
    }
        
    let featureBlock: UIView = {
        let block = UIView()
        block.backgroundColor = .clear
        block.clipsToBounds = true
        return block
    }()
    
    let categoryBlock: UIView = {
        let block = UIView()
        block.backgroundColor = .orange
        return block
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Music"
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        let title = "Jess Glynne channelled Beyonce during her Glastonbury set"
        label.attributedText = title.styleTitle()
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        // 1. Add all views
        addSubview(featureBlock)
        addSubview(categoryBlock)
        categoryBlock.addSubview(categoryLabel)
        addSubview(titleLabel)
       
        
        // 2. Setup constraints
        featureBlock.anchorCenterSuperview()
        featureBlock.anchor(nil, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 180)
        
        let points = [
            CGPoint.zero,
            CGPoint(x: 0.8, y: 0),
            CGPoint(x: 1, y: 0.3),
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 1)
            ]
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.white.cgColor
        featureBlock.layer.insertSublayer(shapeLayer, at: 0)
        
        let path = UIBezierPath()
        path.move(to: convert(relativePoint: points[0]))
        for point in points.dropFirst() {
            path.addLine(to: convert(relativePoint: point))
        }
        path.close()
        
        shapeLayer.path = path.cgPath
        
        
        categoryBlock.anchor(featureBlock.topAnchor, left: featureBlock.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 30)
        categoryLabel.anchorCenterSuperview()
        
        titleLabel.anchor(categoryBlock.bottomAnchor, left: featureBlock.leftAnchor, bottom: nil, right: featureBlock.rightAnchor, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 80)
        
    }
    
    private func convert(relativePoint point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
    }
    
    
    func updateUI(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
