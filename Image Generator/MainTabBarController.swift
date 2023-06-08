//
//  MainTabBarController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeViewController = createVC(
            viewController: HomeViewController(),
            tittle: "Home",
            image: UIImage(named: "iconHouse")
        )
        let favouritesViewController = createVC(
            viewController: FavouritesViewController(),
            tittle: "Favourites",
            image: UIImage(named: "iconHeart")
        )
        viewControllers = [homeViewController, favouritesViewController]
    }
    
    private func createVC(viewController: UIViewController, tittle: String, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.title = tittle
        viewController.tabBarItem.image = image
        return UINavigationController(rootViewController: viewController)
    }
}
