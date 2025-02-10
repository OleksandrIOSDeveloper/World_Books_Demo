//
//  MainTabBarController.swift
//  World News Demo
//
//  Created by Александр Родителев on 19.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controllerArray = [initialTabBar, finalTabBar]
        self.viewControllers = controllerArray
    }
    
    lazy public var initialTabBar: UIViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        if let vc = vc as? MainViewController {
            vc.isSavedBooks = false
        }
        let title = "Books"
        let defaultImage = UIImage(systemName: "book")
        let selectedImage = UIImage(systemName: "book.fill")
        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        
        vc.tabBarItem = tabBarItem
        
        return vc
    }()
    
    lazy public var finalTabBar: UIViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController1 = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        
        guard let vc = viewController1 as? MainViewController else { return UIViewController() }
        vc.isSavedBooks = true
        
        let defaultImage = UIImage(systemName: "bookmark.square")
        let selectedImage = UIImage(systemName: "bookmark.square.fill")
        let tabBarItem = UITabBarItem(title: "Saved", image: defaultImage, selectedImage: selectedImage)
        
        vc.tabBarItem = tabBarItem
        
        return vc
    }()
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TabBarIndexChanged"), object: nil)
    }
    
}

