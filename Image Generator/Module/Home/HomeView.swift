//
//  HomeView.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Subviews

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

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
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(generatorImageView)
        scrollView.addSubview(textField)
        scrollView.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),

            generatorImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            generatorImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            generatorImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            generatorImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),

            textField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textField.topAnchor.constraint(equalTo: generatorImageView.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

            buttonStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10)
        ])
    }
}
