//
//  AppDelegate.swift
//  Movie_app
//
//  Created by Macbook Air on 6/16/21.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let isOnboardingEnded = UserDefaults.standard.bool(forKey: "isOnboardingEnded")
        
        let tabBar = AppDelegate.createTabBarController()
        let onBoardingVC = OnBoardingViewController()
        
        window?.rootViewController = isOnboardingEnded ? tabBar : onBoardingVC
        return true
    }
    
     static func createTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        let movieVC = MainViewController()
        
        movieVC.tabBarItem = UITabBarItem(title: "Фильмы", image: #imageLiteral(resourceName: "Home").withRenderingMode(.alwaysTemplate), tag: 0)
    
        let genreVC = GenreViewController()
        genreVC.tabBarItem = UITabBarItem(title: "Жанр", image: #imageLiteral(resourceName: "Home").withRenderingMode(.alwaysTemplate), tag: 0)
        
        let navMovieVC =  UINavigationController(rootViewController: movieVC)
        let navGenreVC =  UINavigationController(rootViewController: genreVC)
        
        let controllers = [navMovieVC, navGenreVC]
        tabBar.viewControllers = controllers
        tabBar.modalPresentationStyle = .fullScreen
        
        return tabBar
    }

}

