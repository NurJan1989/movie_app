//
//  UICollectionView+Extension.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit

// MARK: - Register cell
extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let cellId = String(describing: cellClass.self)
        register(cellClass.self, forCellWithReuseIdentifier: cellId)
    }
    
    func dequeueCell<T>(_ cellClass: T.Type, indexPath path: IndexPath) -> T {
        let cellId = String(describing: T.self)
        return self.dequeueReusableCell(withReuseIdentifier: cellId, for: path) as! T
    }
}
