//
//  DetailHeaderView.swift
//  Movie_app
//
//  Created by Macbook Air on 6/18/21.
//

import UIKit

class DetailHeaderView: UIView {
    
    var movieData: Result? {
        didSet{
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.set(font: UIFont.systemFont(ofSize: 18, weight: .bold), textColor: .black, textAlignment: .center)
        label.layer.cornerRadius = 24
        label.clipsToBounds = true
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.contentMode = .scaleToFill
        stack.alignment = .leading
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.set(font: UIFont.systemFont(ofSize: 22, weight: .bold), textColor: .black, textAlignment: .left)
        return label
    }()
    
    private let realeseDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.set(font: UIFont.systemFont(ofSize: 22, weight: .bold), textColor: .black, textAlignment: .left)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - ConfigUI
extension DetailHeaderView {
    
    private func configUI() {
        
        backgroundColor = .mainColor
        
        [imageView, voteAverageLabel].forEach {
            addSubview($0)
        }
        
        imageView.addSubview(stackView)
    
        
        [titleLabel, realeseDateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        imageView.snp.makeConstraints { (m) in
            m.width.height.equalToSuperview()
        }
        
        voteAverageLabel.snp.makeConstraints { (m) in
            m.left.top.equalToSuperview().offset(16)
            m.size.equalTo(48)
        }
        
        stackView.snp.makeConstraints { (m) in
            m.left.equalToSuperview().offset(16)
            m.bottom.equalToSuperview().offset(-32)
        }
        
    }
}



