//
//  FilmDetailViewModel.swift
//  Movie_app
//
//  Created by Macbook Air on 6/18/21.
//

import UIKit

enum FilmDetailSectionType: CaseIterable {
    case descr
    case actors
    case simmilarMovies
}

class FilmDetailViewModel {
    
    let filmDetailSectionType = FilmDetailSectionType.allCases
    var actors: [Cast]?
    var movieData: [Result]?
    
    func getActors(path: MovieList, actorsID: Int, compition: @escaping () -> Void) {
        NetworkService.shared.getActors(path: path, actorsId: actorsID) { (state) in
            switch state {
            case .loading:
                print("Loading")
            case .error( let error):
                print(error)
            case .result(let actors):
                self.actors = actors.cast
                DispatchQueue.main.async {
                    compition()
                }

            }
        }
    }
    
    func getMovies(path: MovieList, movieId: Int, compition: @escaping () -> Void) {
        NetworkService.shared.getSimilarMovies(path: path, movieId: movieId) { (state) in
            switch state {
            case .loading:
                print("Loading")
            case .error( let error):
                print(error)
            case .result(let movies):
                self.movieData = movies.results
                DispatchQueue.main.async {
                    compition()
                }
            }
        }
    }
    
}
