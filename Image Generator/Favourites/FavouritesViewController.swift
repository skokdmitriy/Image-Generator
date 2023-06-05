//
//  FavouritesViewController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    let tableview: UITableView = {
        let table = UITableView()
        table.register(FavouritesCell.self, forCellReuseIdentifier: "FavouritesCell")
        return table
    }()
        
    var favouritesImages: [UIImage] {
        get {
            return (self.tabBarController?.viewControllers![0] as! HomeViewController).dataImage
        }
    }
    
//    MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 200
        view.addSubview(tableview)
        
        print(favouritesImages.count)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
}

// MARK: - Table view
    
extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesImages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell") as! FavouritesCell
        cell.favoriteImageView.image = favouritesImages[indexPath.row]
        return cell
    }
}
