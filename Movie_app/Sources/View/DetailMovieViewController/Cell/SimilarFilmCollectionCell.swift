//
//  SimilarFilmCollectionCell.swift
//  Movie_app
//
//  Created by Macbook Air on 6/19/21.
//

import UIKit

class SimilarFilmCollectionCell: UICollectionViewCell {
    
    var movieData: Result? {
        didSet {
            guard let movieData = movieData else { return }
            voteAverageLabel.text = String(movieData.voteAverage ?? 0)
            imageView.setImage(imageUrl: movieData.bestUrl)
        }
    }
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
       let label = UILabel()
        var size: CGFloat = 16
        var cornerRadius: CGFloat = 24
        
        if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            size = 14
            cornerRadius = 20
        }
        
        label.set(font: UIFont.systemFont(ofSize: size, weight: .bold), textColor: .black, textAlignment: .center)
        label.layer.cornerRadius = cornerRadius
        label.clipsToBounds = true
        label.backgroundColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

//MARK: - ConfigUI
extension SimilarFilmCollectionCell {
    private func configUI() {
        
        selectedBackgroundView = .none
        
        addSubview(imageView)
        imageView.addSubview(voteAverageLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
        voteAverageLabel.snp.makeConstraints { (m) in
            m.left.top.equalToSuperview().offset(16)
            if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
                m.size.equalTo(40)
            }
            m.size.equalTo(48)
        }

    }
}
