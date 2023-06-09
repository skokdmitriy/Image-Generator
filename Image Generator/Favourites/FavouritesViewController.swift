//
//  FavouritesViewController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

final class FavouritesViewController: UIViewController {
    var favouritesImages = [UIImage]()

    // MARK: - Subviews

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: "FavouritesCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        favouritesImages.removeAll()
        fetchImage()
        tableView.reloadData()
    }

    // MARK: Private

    @objc private func deleteAllTapped() {
        DataBaseHelper.shared.deleteAllImage()
        favouritesImages.removeAll()
        tableView.reloadData()
    }

    private func fetchImage() {
        let dataImages = DataBaseHelper.shared.fetchImage()

        for i in dataImages {
            let image = UIImage(data: i.img!)
            favouritesImages.append(image!)
        }
    }

    private func setupNavigationBar () {
        navigationItem.title = "Favourites images"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "icon.Trash.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(deleteAllTapped)
        )
    }

    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouritesImages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell") as? FavouritesCell else {
            return UITableViewCell()
        }
        let image = favouritesImages[indexPath.row]
        cell.configure(with: image)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favouritesImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            DataBaseHelper.shared.deleteImage(indexPath: indexPath)
        }
    }
}
