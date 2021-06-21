//
//  SimilarFilmCell.swift
//  Movie_app
//
//  Created by Macbook Air on 6/19/21.
//

import UIKit

class SimilarFilmCell: UITableViewCell {
    
    var movies: [Result]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var tapToItem: (([Result]?, IndexPath) -> Void)?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(SimilarFilmCollectionCell.self)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDelegate
extension SimilarFilmCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let tapToItem = tapToItem {
            tapToItem(movies, indexPath)
        }
        
    }
}

//MARK: - UICollectionViewDataSource
extension SimilarFilmCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(SimilarFilmCollectionCell.self, indexPath: indexPath)
        cell.movieData = movies?[indexPath.row]
        return cell
    }
    
}

//MARK: - UICollectionViewDataSource
extension SimilarFilmCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let leftRightPadding: CGFloat = 16
        let spaces:CGFloat = 8
        let cellWidth = (screenWidth - leftRightPadding - spaces) / 2
        let cellHeight = screenHeight  / 3.5
        return CGSize(width: cellWidth , height: cellHeight)
        
    }
}

//MARK: - ConfigUI
extension SimilarFilmCell {
    private func configUI() {
        contentView.addSubview(collectionView)
        
        selectionStyle = .none
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { (m) in
            m.left.top.equalToSuperview().offset(8)
            m.right.bottom.equalToSuperview().offset(-8)
        }
    }
    
}
    
    
