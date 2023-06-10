//
//  FavoritesCell.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 03.06.2023.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    // MARK: - Subviews

    private lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    //    MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    MARK: - Functions

    func configure(with image: UIImage) {
        favoriteImageView.image = image
    }

    //    MARK: - Layout

    private func configureConstraints() {
        addSubview(favoriteImageView)

        NSLayoutConstraint.activate([
            favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 180),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}
