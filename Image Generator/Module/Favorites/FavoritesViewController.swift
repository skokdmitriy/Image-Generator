//
//  FavoritesViewController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    private var favoritesImages = [UIImage]()

    // MARK: - Subviews

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: Constants.favoriteCellName)
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

        fetchImage()
        tableView.reloadData()
    }

    // MARK: - Private

    @objc private func deleteAllTapped() {
        DataBaseHelper.shared.deleteAllImage()
        favoritesImages.removeAll()
        tableView.reloadData()
    }

    private func fetchImage() {
        favoritesImages.removeAll()
        favoritesImages = DataBaseHelper.shared.fetchImage()
    }

    private func setupNavigationBar () {
        title = Constants.favoriteTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: Constants.navigationRightButtonItemIcon),
            style: .plain,
            target: self,
            action: #selector(deleteAllTapped)
        )
    }

    //    MARK: - Layout

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

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesImages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoriteCellName) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        let image = favoritesImages[indexPath.row]
        cell.configure(with: image)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoritesImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            DataBaseHelper.shared.deleteImage(indexPath: indexPath)
        }
    }
}
