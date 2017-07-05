//
//  MTippy.swift
//  NewsFeed
//
//  Created by Malcolm Kumwenda on 2017/07/05.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit

enum MTipDirection {
    case up, down, left, right
}

class MTippy: UIView {
    let tipLabel: UILabel = {
        let label = UILabel()
        label.text = "This will be the tip"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tipLabel)
        tipLabel.fillSuperview()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func present(_ direction: MTipDirection, on view: UIView, with text: String) {
        view.addSubview(self)
        setNeedsLayout()
    }
}
