//
//  ActorsCollectionCell.swift
//  Movie_app
//
//  Created by Macbook Air on 6/18/21.
//

import UIKit

class ActorsCollectionCell: UICollectionViewCell {
    
    var actor: Cast? {
        didSet {
            guard let actor = actor else { return }
            
            if actor.profilePath == nil {
                imageView.image = #imageLiteral(resourceName: "noPic")
            } else {
                imageView.setImage(imageUrl: actor.bestUrl ?? "")
            }
            nameLabel.text = actor.name
        }
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.textAlignment = .center
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
extension ActorsCollectionCell {
    private func configUI() {
        
        addSubview(stackView)
        
        [imageView, nameLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
    
}
