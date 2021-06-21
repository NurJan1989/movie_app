//
//  NetworkService.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import Foundation
import Alamofire

enum Results<T> {
    case error(String)
    case complition(T)
}

enum ScreenState<T> {
    case loading
    case error(String)
    case result(T)
}

enum MovieList: String {
    case popular = "popular"
    case upcoming = "upcoming"
    case genre = "genre"
    case discover
    case actors = "credits"
    case similar = "similar"
}

class NetworkService {
    static var shared = NetworkService()
    
    private init() {}
    
    private func sendRequest<T: Codable>(  path: MovieList,
                                           id: Int = 0,
                                           method: HTTPMethod = .get,
                                           headers: HTTPHeaders? = nil,
                                           parseType: T.Type,
                                           complition: @escaping (Results<T>) -> Void) {
        var urlString = ""
        
        switch path {
        case .genre:
            urlString = Base.genreURL
        case .discover:
            urlString = Base.discoverURL + String(id)
        case .actors:
            urlString = Base(id: id, path: path).baseURL
        case .similar:
            urlString = Base(id: id, path: path).baseURL
        case .popular, .upcoming:
            urlString = Base(path: path).baseURL
        }
        
        guard let url = URL(string: urlString) else {
            complition(.error("URL not convert"))
            return
        }
        
        AF.request(url, method: method, headers: headers).responseData { (data) in
            if let data = data.data {
                do {
                    let result = try JSONDecoder().decode(parseType, from: data)
                    complition(.complition(result))
                } catch {
                    complition(.error(error.localizedDescription))
                }
            } else {
                complition(.error(data.error?.localizedDescription ?? ""))
            }
        }
    }
    
    func getData(path: MovieList, complition: @escaping (ScreenState<MovieModel>) -> Void) {
        complition(.loading)
        sendRequest(path: path, parseType: MovieModel.self) { (result) in
            switch result {
            case .error(let error):
                complition(.error(error))
            case .complition(let movies):
                complition(.result(movies))
                print(complition(.result(movies)))
            }
        }
    }
    
    func getGenre(path: MovieList, complition: @escaping (ScreenState<GenreModel>) -> Void) {
        complition(.loading)
        sendRequest(path: path, parseType: GenreModel.self) { (result) in
            switch result {
            case .error(let error):
                complition(.error(error))
            case .complition(let genres):
                complition(.result(genres))
                print(complition(.result(genres)))
            }
        }
    }
    
    func getDataByGenre(path: MovieList, genresId: Int, complition: @escaping (ScreenState<MovieModel>) -> Void) {
        complition(.loading)
        sendRequest(path: path, id: genresId, parseType: MovieModel.self) { (result) in
            switch result {
            case .error(let error):
                complition(.error(error))
            case .complition(let movies):
                complition(.result(movies))
                print(complition(.result(movies)))
            }
        }
    }
    
    func getActors(path: MovieList, actorsId: Int, complition: @escaping (ScreenState<FilmDetailModel>) -> Void) {
        complition(.loading)
        sendRequest(path: path, id: actorsId, parseType: FilmDetailModel.self) { (result) in
            switch result {
            case .error(let error):
                complition(.error(error))
            case .complition(let actors):
                complition(.result(actors))
                print(complition(.result(actors)))
            }
        }
    }
    
    func getSimilarMovies(path: MovieList, movieId: Int, complition: @escaping (ScreenState<MovieModel>) -> Void) {
        complition(.loading)
        sendRequest(path: path, id: movieId, parseType: MovieModel.self) { (result) in
            switch result {
            case .error(let error):
                complition(.error(error))
            case .complition(let movies):
                complition(.result(movies))
                print(complition(.result(movies)))
            }
        }
    }
    
}
