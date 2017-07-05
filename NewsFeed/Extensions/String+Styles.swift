//
//  String+Styles.swift
//  NewsFeed
//
//  Created by Malcolm Kumwenda on 2017/07/05.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import BonMot

extension String {
    func styleTitle() -> NSAttributedString {
        let style = StringStyle(
            .font(UIFont(name: "HelveticaNeue-Bold", size: 20)!),
            .lineHeightMultiple(1)
        )
        
        let attributedString = self.styled(with: style)
        return attributedString
    }
}
