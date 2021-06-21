//
//  String+Extension.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit

extension String {
    var localized: String {
        if let bundlePath = Bundle.main.path(forResource: "", ofType: "lproj"), let bundle = Bundle(path: bundlePath) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
        }else{
            return ""
        }
    }
}
