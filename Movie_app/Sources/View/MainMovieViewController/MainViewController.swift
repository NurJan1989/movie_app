//
//  MainViewController.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit

class MainViewController: UIViewController {
    
    private let viewModel = MoviewViewModel()
    
    var movieModel: [Result]?
    var path: MovieList = .popular
    var genrePath: MovieList = .discover
    var genresId: Int? {
        didSet {
            segmentController.isHidden = true
            getDataByGenre(id: genresId ?? 0)
        }
    }
    
    private lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var segmentController: UISegmentedControl = {
        let items = ["Популярное", "Скоро на экранах"]
        let segment = UISegmentedControl(items: items)
        segment.apportionsSegmentWidthsByContent = false
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .gray
        segment.tintColor = .clear
        segment.layer.borderWidth = 0
        segment.layer.borderColor = UIColor.clear.cgColor
        segment.layer.cornerRadius = 0
        segment.clipsToBounds = false
        segment.contentMode = .scaleAspectFill
        segment.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
        return segment
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.registerCell(MainCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        makeRequest()
    }
}

//MARK: - Actions
extension MainViewController {
    @objc private func segmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            path = .popular
        } else {
            path = .upcoming
        }
        
        makeRequest()
    }
}

//MARK: - MakeRequest
extension MainViewController {
    private func makeRequest() {
        viewModel.getData(path: path) { [weak self] in
            guard let wSelf = self else { return }
            wSelf.collectionView.reloadData()
        }
    }
    
    private func getDataByGenre(id: Int) {
        viewModel.getDataByGenre(path: genrePath, genresId: id) { [weak self] in
            guard let wSelf = self else { return }
            wSelf.collectionView.reloadData()
        }
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText != "" {
            let movie = viewModel.modieData.filter { (list: Result) -> Bool in
                (list.title?.lowercased().contains(searchText.lowercased()))!
            }
            viewModel.modieData = movie
            collectionView.reloadData()
            
        } else {
            makeRequest()
        }
    }
    
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = viewModel.modieData[indexPath.row]
        let vc = FilmDetailViewController()
        vc.movieData = movie
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.modieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueCell(MainCell.self, indexPath: indexPath)
        let movie = viewModel.modieData[indexPath.row]
        cell.movieData = movie
        return cell
        
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let leftRightPadding: CGFloat = 24
        let spaces:CGFloat = 45
        let cellWidth = (screenWidth - leftRightPadding - spaces)
        return CGSize(width: cellWidth , height: cellWidth)
        
    }
}

//MARK: - ConfigUI
extension MainViewController {
    private func configUI() {
        
        navigationItem.titleView = searchBar
        view.backgroundColor = .mainColor
        
        [segmentController, collectionView].forEach {
            view.addSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        segmentController.snp.makeConstraints { (m) in
            m.left.equalToSuperview().offset(8)
            m.right.equalToSuperview().offset(-8)
            m.height.equalTo(36)
            m.top.equalTo(view.safeAreaLayoutGuide).offset(8)
        }
        
        collectionView.snp.makeConstraints { (m) in
            if segmentController.isHidden {
                m.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            }
            m.top.equalTo(segmentController.snp.bottom).offset(10)
            m.left.right.bottom.equalToSuperview()
        }
        
    }
}
