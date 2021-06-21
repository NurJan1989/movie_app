//
//  UIImageView+Extension.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
