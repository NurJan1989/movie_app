//
//  MainCell.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit
import Kingfisher

class MainCell: UICollectionViewCell {
    
    var movieData: Result? {
        didSet {
            guard let movieData = movieData else { return }
            voteAverageLabel.text = String(movieData.voteAverage ?? 0)
            titleLabel.text = movieData.title
            realeseDateLabel.text = movieData.releaseDate
            imageView.setImage(imageUrl: movieData.bestUrl)
        }
    }
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.alpha = 0.5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
       let label = UILabel()
        label.set(font: UIFont.systemFont(ofSize: 16, weight: .bold), textColor: .black, textAlignment: .center)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.set(font: UIFont.systemFont(ofSize: 22, weight: .bold), textColor: .white, textAlignment: .center)
         return label
    }()
   
    private let realeseDateLabel: UILabel = {
        let label = UILabel()
        label.set(font: UIFont.systemFont(ofSize: 22, weight: .bold), textColor: .white, textAlignment: .center)
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
extension MainCell {
    private func configUI() {
        
        [voteAverageLabel].forEach {
            $0.layer.cornerRadius = 24
            $0.clipsToBounds = true
            $0.backgroundColor = .white
        }
        
        selectedBackgroundView = .none
        [imageView,voteAverageLabel, titleLabel, realeseDateLabel ].forEach {
            addSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
        voteAverageLabel.snp.makeConstraints { (m) in
            m.left.top.equalToSuperview().offset(16)
            m.size.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.left.equalToSuperview().offset(32)
            m.right.equalToSuperview().offset(-32)
        }
        realeseDateLabel.snp.makeConstraints { (m) in
            m.centerX.equalTo(titleLabel)
            m.top.equalTo(titleLabel.snp.bottom).offset(8)
            m.left.equalToSuperview().offset(32)
            m.right.equalToSuperview().offset(-32)
        }
    }
}
