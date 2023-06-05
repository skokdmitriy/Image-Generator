//
//  FavouritesCell.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 03.06.2023.
//

import UIKit

class FavouritesCell: UITableViewCell {
    
    var favoriteImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstrains() {
        addSubview(favoriteImageView)
        
        NSLayoutConstraint.activate([
            favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 180),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}
