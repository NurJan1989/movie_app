//
//  FilmDetailModel.swift
//  Movie_app
//
//  Created by Macbook Air on 6/18/21.
//

import Foundation

struct FilmDetailModel: Codable {
    let id: Int?
    let cast: [Cast]?
}

struct Cast: Codable {
    let name: String?
    let profilePath: String?
    
    var bestUrl: String? {
        return "https://image.tmdb.org/t/p/w500\(profilePath ?? "nil")"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }
}
