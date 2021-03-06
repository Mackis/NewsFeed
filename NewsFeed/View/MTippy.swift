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
    
    @IBOutlet weak var tipLabel: UILabel!
    
    var view: UIView!
    
    func viewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MTippy", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(){
        view = viewFromNib()
        view.frame = bounds
        addSubview(view)
        translatesAutoresizingMaskIntoConstraints = false
        
        // Add customization here
        view.backgroundColor = .white
        view.layer.cornerRadius = 4.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4.0
        view.layer.shadowOffset = CGSize(width: 0.0,height: 8.0)
    }
    
    func present(tip:String, direction: MTipDirection, toView: UIView ){
        self.alpha = 0
        toView.addSubview(self)
        tipLabel.text = tip
        let difference = (toView.frame.height-self.frame.height)*1.7
        toView.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: toView, attribute: .centerY, multiplier: 1, constant: -difference))
        toView.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: toView, attribute: .centerX, multiplier: 1, constant: 0))
        toView.needsUpdateConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissView))
        tap.delegate = self
        addGestureRecognizer(tap)
        
        transform = CGAffineTransform(scaleX: 0, y: 0.1)
        UIView.animate(withDuration: 0.3, animations: { () -> () in
            self.alpha = 1.0
            self.transform = CGAffineTransform.identity
        })
        
        
    }
    
    @objc func dissmissView() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (finished) -> Void in
            self.removeFromSuperview()
        }
    }
}

extension MTippy: UIGestureRecognizerDelegate {

    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


