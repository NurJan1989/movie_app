//
//  OnBoardingCell.swift
//  Movie_app
//
//  Created by Macbook Air on 6/20/21.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            imageView.image = image
        }
    }
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: ConfigUI
extension OnBoardingCell {
    private func configUI() {
        
        addSubview(imageView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
}

