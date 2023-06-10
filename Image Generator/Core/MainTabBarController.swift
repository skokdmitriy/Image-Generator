//
//  MainTabBarController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    // MARK: - Private

    private func setupTabBar() {
        let homeViewController = createVC(
            viewController: HomeViewController(),
            tittle: Constants.tabBarItemHomeName,
            image: UIImage(named: Constants.tabBarItemHomeImage)
        )
        let favoritesViewController = createVC(
            viewController: FavoritesViewController(),
            tittle: Constants.tabBarItemFavoritesName,
            image: UIImage(named: Constants.tabBarItemFavoritesImage)
        )
        viewControllers = [homeViewController, favoritesViewController]
    }

    private func createVC(viewController: UIViewController, tittle: String, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.title = tittle
        viewController.tabBarItem.image = image
        return UINavigationController(rootViewController: viewController)
    }
}
