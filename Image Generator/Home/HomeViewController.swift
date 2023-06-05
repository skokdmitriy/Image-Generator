//
//  HomeViewController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeView = HomeView()
    lazy var dataProvider = DataProvider()
    
    var loadImage = UIImage()
    var dataImage = [UIImage]()
    
//    MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupKeyBoardingHiding()
        setupDismissKeyboardGesture()
        homeView.generatorButton.addTarget(self, action: #selector(generatorButtonTapped), for: .touchUpInside)
        homeView.favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        homeView.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc func generatorButtonTapped() {
        
        guard let inputView = homeView.textField.text else { return }
        let text = String(inputView).replacingOccurrences(of: " ", with: "%20")
        
        let urlAPI = "https://dummyimage.com/400x400/000/ffffff&text=\(text)"
        guard let url = URL(string: urlAPI) else { fatalError("someError") }
        
        dataProvider.downloadImage(url: url) { image in
            guard let image = image else { return }
            self.loadImage = image
            self.homeView.generatorImageView.image = self.loadImage
            self.homeView.favouriteButton.isEnabled = true
            self.homeView.favouriteButton.backgroundColor = .systemBlue
        }
        view.endEditing(true)
        self.homeView.textField.text = nil
    }
    
    @objc func favouriteButtonTapped() {
        if dataImage.count == 10 {
            dataImage.removeFirst()
        } else {
            dataImage.append(loadImage)
            print(dataImage.count)
        }
    }
    
    @objc private func textFieldChanged() {
        if homeView.textField.text != nil {
            homeView.generatorButton.isEnabled = true
            homeView.generatorButton.backgroundColor = .systemBlue
        } else {
            homeView.generatorButton.isHidden = false
        }
    }
}

// MARK: - Keyboard

extension HomeViewController {
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.ended {
            view.endEditing(true)
        }
    }
    
    private func setupKeyBoardingHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
                NSValue,
              let currentTextField = UIResponder.currentFirst () as? UITextField else {
            return
        }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
}
