//
//  MovieModel.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import Foundation

struct MovieModel: Codable {
    var results: [Result]
    var totalPages: Int?
    var page: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

struct Result: Codable {
    let id: Int?
    let overview: String?
    let posterPath: String?
    var bestUrl: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "nil")"
    }
    let releaseDate: String?
    let title: String?
    let voteAverage: Double?
    
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
