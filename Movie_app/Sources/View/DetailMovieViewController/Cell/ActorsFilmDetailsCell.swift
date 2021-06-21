//
//  ActorsFilmDetailsCell.swift
//  Movie_app
//
//  Created by Macbook Air on 6/18/21.
//

import UIKit

class ActorsFilmDetailsCell: UITableViewCell {
    
    var actors: [Cast]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        collectionView.registerCell(ActorsCollectionCell.self)
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
extension ActorsFilmDetailsCell: UICollectionViewDelegate {
}

//MARK: - UICollectionViewDataSource
extension ActorsFilmDetailsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ActorsCollectionCell.self, indexPath: indexPath)
        let actor = actors?[indexPath.row]
        cell.actor = actor
        return cell
    }
    
}

//MARK: - UICollectionViewDataSource
extension ActorsFilmDetailsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var devideBy:CGFloat = 3
        if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            devideBy = 2.5
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let leftRightPadding: CGFloat = 24
        let spaces:CGFloat = 45
        let cellWidth = (screenWidth - leftRightPadding - spaces) / devideBy
        let cellHeight = cellWidth + 20
        return CGSize(width: cellWidth , height: cellHeight)
        
    }
}

//MARK: - ConfigUI
extension ActorsFilmDetailsCell {
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
