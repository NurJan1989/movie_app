//
//  GenreViewController.swift
//  Movie_app
//
//  Created by Macbook Air on 6/17/21.
//

import UIKit

class GenreViewController: UIViewController {
    
    private let viewModel = GenreViewModel()
    private let path: MovieList = .genre
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(UITableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        makeRequest()
    }
}

//MARK: - MakeRequest
extension GenreViewController {
    private func makeRequest() {
        viewModel.getGenre(path: path) { [weak self] in
            guard let wSelf = self else { return }
            wSelf.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate
extension GenreViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = viewModel.genreData[indexPath.row]
        let vc = MainViewController()
        vc.genresId = id.id
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension GenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.genreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(UITableViewCell.self, indexPath: indexPath)
        cell.textLabel?.text = viewModel.genreData[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - ConfigUI
extension GenreViewController {
    private func configUI() {
        
        view.addSubview(tableView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
}
