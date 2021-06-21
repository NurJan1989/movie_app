//
//  Constants.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

struct Constants {
    static let apiKey = "af0a8e44a581074982ecfd43740a49a3"
}

struct Base {
    var baseURL = "https://api.themoviedb.org/3/movie/"
    static var genreURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Constants.apiKey)"
    static var discoverURL = "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&with_genres="
    
    init(path: MovieList) {

        baseURL += (path.rawValue  + "?api_key=" + Constants.apiKey)
        
    }
    
    init(id: Int, path: MovieList) {
        baseURL += (String(id) + "/\(path.rawValue)?api_key=" + Constants.apiKey)
    }
}
