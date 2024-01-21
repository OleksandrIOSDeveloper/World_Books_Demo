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
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            let selectedIndex = tabBarController.selectedIndex
            print("Выбрана вкладка с индексом: \(selectedIndex)")
   
        if let selectedViewController = tabBarController.viewControllers?[1] as? ViewController {
            selectedViewController.isSavedBooks = true
               }
        }
}
