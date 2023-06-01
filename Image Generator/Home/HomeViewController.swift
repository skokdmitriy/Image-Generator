//
//  HomeViewController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeView = HomeView()
    
    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

    }

}
