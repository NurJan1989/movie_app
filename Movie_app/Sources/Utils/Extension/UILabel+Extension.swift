//
//  UILabel+Extension.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit

extension UILabel {
    func set(font:UIFont, textColor:UIColor, textAlignment: NSTextAlignment ) {
        self.font = font
        self.textColor = textColor
        self.numberOfLines = 0
        self.textAlignment = textAlignment
    }
}
