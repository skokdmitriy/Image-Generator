//
//  HomeView.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Subviews

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.tittleLabelName
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var generatorImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.generatorImageViewImage)
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let textField: UITextField = {
        let text = UITextField()
        text.placeholder = Constants.textFieldPlaceHolder
        text.textAlignment = .center
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    let generatorButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.generatorButtonTitle, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.favoriteButtonTitle, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(generatorButton)
        stackView.addArrangedSubview(favoriteButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    //    MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    MARK: - Layout

    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(generatorImageView)
        addSubview(textField)
        addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

            generatorImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            generatorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            generatorImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            generatorImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),

            textField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            textField.topAnchor.constraint(equalTo: generatorImageView.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),

            buttonStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}
