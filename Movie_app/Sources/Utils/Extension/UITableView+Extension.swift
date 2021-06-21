//
//  UITableView+Extension.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        let cellId = String(describing: cellClass.self)
        register(cellClass.self, forCellReuseIdentifier: cellId)
    }
    
    func dequeueCell<T>(_ cellClass: T.Type, indexPath path: IndexPath) -> T {
        let cellId = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: cellId, for: path) as! T
    }
}
