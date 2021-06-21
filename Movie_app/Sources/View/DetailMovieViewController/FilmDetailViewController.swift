//
//  FilmDetailViewController.swift
//  Movie_app
//
//  Created by Macbook Air on 6/18/21.
//

import UIKit

class FilmDetailViewController: UIViewController {
    
    private let viewModel = FilmDetailViewModel()
    
    var movieData: Result?
    var actorsPath: MovieList = .actors
    var moviePath: MovieList = .similar
    let heightForHeader: CGFloat = 40

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.registerCell(UITableViewCell.self)
        tableView.registerCell(ActorsFilmDetailsCell.self)
        tableView.registerCell(SimilarFilmCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        makeRequest()
    }

}

//MARK: - MakeRequest
extension FilmDetailViewController {
    
    private func makeRequest() {
        getActors()
        getMovies()
    }
    
    private func getActors() {
        viewModel.getActors(path: actorsPath, actorsID: movieData?.id ?? 0) { [weak self] in
            guard let wSelf = self else { return }
                wSelf.tableView.reloadData()
        }
    }
    
    private func getMovies() {
        viewModel.getMovies(path: moviePath, movieId: movieData?.id ?? 0) { [weak self] in
            guard let wSelf = self else { return }
                wSelf.tableView.reloadData()
        }
    }
    
}

//MARK: - UITableViewDelegate
extension FilmDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType = viewModel.filmDetailSectionType[section]
        
        switch sectionType {
        case .descr:
            return view.frame.height / 2.5
        case .actors:
            return heightForHeader
        case .simmilarMovies:
            return heightForHeader
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = viewModel.filmDetailSectionType[indexPath.section]
        
        switch sectionType {
        case .descr:
            return UITableView.automaticDimension
        case .actors:
            return view.frame.height / 2
        case .simmilarMovies:
            return view.frame.height / 3
        }
    }

}

//MARK: - UITableViewDataSource
extension FilmDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.filmDetailSectionType.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = viewModel.filmDetailSectionType[indexPath.section]
        
        switch  sectionType {
        case .descr:
            let cell = tableView.dequeueCell(UITableViewCell.self, indexPath: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = movieData?.overview
            return cell
        case .actors:
            let cell = tableView.dequeueCell(ActorsFilmDetailsCell.self, indexPath: indexPath)
            cell.actors = viewModel.actors
            return cell
        case.simmilarMovies:
            let cell = tableView.dequeueCell(SimilarFilmCell.self, indexPath: indexPath)
            cell.movies = viewModel.movieData
            cell.tapToItem = { [weak self] movies, index in
                guard let wSelf = self else { return }
                let filmDetail = movies?[index.row]
                let filmDetailVC = FilmDetailViewController()
                filmDetailVC.movieData = filmDetail
                wSelf.navigationController?.pushViewController(filmDetailVC, animated: true)
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = viewModel.filmDetailSectionType[section]
        
        let view = UIView()
        let label: UILabel = {
            let label = UILabel(frame: CGRect(x: 20 , y: 10, width: UIScreen.main.bounds.width, height: 30))
            label.set(font: UIFont.systemFont(ofSize: 20, weight: .bold), textColor: .black, textAlignment: .left)
            
            return label
        }()
        
        view.addSubview(label)
        
        
        switch sectionType {
        case .descr:
            let view = DetailHeaderView()
            view.movieData = movieData
            return view
        case .actors:
            label.text = "Actors"
        case .simmilarMovies:
            label.text = "Similar movies"
        }
        
        return view
    }
      
}

//MARK: - ConfigUI
extension FilmDetailViewController {
    private func configUI() {
        view.addSubview(tableView)

        makeConstraints()
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { (m) in
            m.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
