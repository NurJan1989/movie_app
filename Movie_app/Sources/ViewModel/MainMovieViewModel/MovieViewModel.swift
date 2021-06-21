//
//  MovieViewModel.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit

class MoviewViewModel {
    
    var modieData = [Result]()
    
    func getData(path: MovieList, compition: @escaping () -> Void) {
        NetworkService.shared.getData(path: path){ (state) in
            switch state {
            case .loading:
                print("Loading")
            case .error( let error):
                print(error)
            case .result(let movie):
                self.modieData = movie.results
                DispatchQueue.main.async {
                    compition()
                }
            }
        }
    }
    
    func getDataByGenre(path: MovieList, genresId: Int, compition: @escaping () -> Void) {
        NetworkService.shared.getDataByGenre(path: path, genresId: genresId) { (state) in
            switch state {
            case .loading:
                print("Loading")
            case .error( let error):
                print(error)
            case .result(let movie):
                self.modieData = movie.results
                DispatchQueue.main.async {
                    compition()
                }
            }
        }
    }

}
