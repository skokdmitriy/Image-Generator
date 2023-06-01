//
//  HomeView.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

class HomeView: UIView {
    
    //    MARK: - Subviews
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Image Generator"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let generatorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "400")
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let textField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter any text"
        text.textAlignment = .center
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let generatorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let favouriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Like", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(generatorButton)
        stackView.addArrangedSubview(favouriteButton)
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
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(generatorImage)
        addSubview(textField)
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            generatorImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            generatorImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            generatorImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            generatorImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            textField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            textField.topAnchor.constraint(equalTo: generatorImage.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}
