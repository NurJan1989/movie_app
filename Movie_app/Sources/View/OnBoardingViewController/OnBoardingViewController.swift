//
//  OnBoardingViewController.swift
//  Movie_app
//
//  Created by Macbook Air on 6/20/21.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    private let image: [UIImage] = [#imageLiteral(resourceName: "venom2"), #imageLiteral(resourceName: "fast"), #imageLiteral(resourceName: "tomraider"), #imageLiteral(resourceName: "bodyguard")]
    private let userDefaults = UserDefaults.standard
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.registerCell(OnBoardingCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let pageIndicator: UIPageControl = {
        let pageIndicator = UIPageControl()
        pageIndicator.currentPage = 0
        pageIndicator.currentPageIndicatorTintColor = .blue
        pageIndicator.pageIndicatorTintColor = .white
        return pageIndicator
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isHidden = true
        button.addTarget(self, action: #selector(startButtonPress), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
 
}

//MARK: - Actions
extension OnBoardingViewController {
    @objc private func startButtonPress() {
        userDefaults.set(true, forKey: "isOnboardingEnded")
        
        let tabBar = AppDelegate.createTabBarController()
        UIApplication.shared.windows.last?.rootViewController = tabBar
        UIApplication.shared.windows.last?.makeKeyAndVisible()
        
    }
}

//MARK: -UICollectionViewDelegate
extension OnBoardingViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        let isLastPage = pageNumber == image.count - 1
        startButton.isHidden = !isLastPage
        pageIndicator.isHidden = isLastPage
        
        pageIndicator.currentPage = Int(pageNumber)
    }
}

//MARK: - UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(OnBoardingCell.self, indexPath: indexPath)
        cell.image = image[indexPath.row]
        return cell
    }
    
}
//MARK: - UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
}

//MARK: - ConfigUI
extension OnBoardingViewController {
    private func configUI() {
        view.backgroundColor = .white
        pageIndicator.numberOfPages = image.count
        
        [collectionView, pageIndicator, startButton].forEach {
            view.addSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
        pageIndicator.snp.makeConstraints { (m) in
            m.left.equalToSuperview().offset(32)
            m.right.equalToSuperview().offset(-32)
            m.bottom.equalToSuperview().offset(-30)
        }
        
        startButton.snp.makeConstraints { (m) in
            m.left.equalToSuperview().offset(32)
            m.right.equalToSuperview().offset(-32)
            m.bottom.equalToSuperview().offset(-30)
            
            if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
                m.height.equalTo(40)
            }
            m.height.equalTo(60)
        }
        
    }
}
