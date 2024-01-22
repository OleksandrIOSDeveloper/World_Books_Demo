//
//  MainTabBarController.swift
//  World News Demo
//
//  Created by Александр Родителев on 19.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controllerArray = [initialTabBar, finalTabBar]
        self.viewControllers = controllerArray
    }
    
    lazy public var initialTabBar: UIViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        if let vc = vc as? ViewController {
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
        let viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        guard let vc = viewController1 as? ViewController else { return UIViewController() }
        vc.isSavedBooks = true
        
        let defaultImage = UIImage(systemName: "bookmark.square")
        let selectedImage = UIImage(systemName: "bookmark.square.fill")
        let tabBarItem = UITabBarItem(title: "Saved", image: defaultImage, selectedImage: selectedImage)
        
        vc.tabBarItem = tabBarItem
        
        return vc
    }()
    
}

