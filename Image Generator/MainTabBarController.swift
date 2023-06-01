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
            createVC(viewController: HomeViewController(), tittle: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill")),
            createVC(viewController: FavouritesViewController(), tittle: "Favourites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        ]
    }
    
    private func createVC(viewController: UIViewController, tittle: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = tittle
        viewController.tabBarItem.image = image
        return viewController
    }

}
