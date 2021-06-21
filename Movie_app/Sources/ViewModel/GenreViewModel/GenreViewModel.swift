//
//  GenreViewModel.swift
//  Movie_app
//
//  Created by Macbook Air on 6/17/21.
//

import UIKit

class GenreViewModel {
    
    var genreData = [Genres]()
    
    func getGenre(path: MovieList, compition: @escaping () -> Void) {
        NetworkService.shared.getGenre(path: path) { (state) in
            switch state {
            case .loading:
                print("Loading")
            case .error( let error):
                print(error)
            case .result(let genre):
                self.genreData = genre.genres
                DispatchQueue.main.async {
                    compition()
                }

            }
        }
    }
}
