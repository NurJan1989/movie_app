//
//  GenreModel.swift
//  Movie_app
//
//  Created by Macbook Air on 6/17/21.
//

import Foundation

struct GenreModel: Codable {
    let genres: [Genres]
}

struct Genres: Codable {
    let id: Int
    let name: String
}
