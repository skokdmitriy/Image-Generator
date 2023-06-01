//
//  SceneDelegate.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let WindowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: WindowScene)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
}
