//
//  MainTabBarController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()

    }
    
    private func setupTabBar() {
        viewControllers = [
            createVC(viewController: HomeViewController(), tittle: "Home", image: UIImage(named: "house")),
            createVC(viewController: FavouritesViewController(), tittle: "Favourites", image: UIImage(named: "heart"))
            
        ]
    }
    
    private func createVC(viewController: UIViewController, tittle: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = tittle
        viewController.tabBarItem.image = image
        return viewController
    }

}
