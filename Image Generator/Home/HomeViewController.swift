//
//  HomeViewController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    private lazy var homeView = HomeView()

    private var loadImage = UIImage()

    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupKeyBoardingHiding()
        setupDismissKeyboardGesture()
        addTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func addTarget() {
        homeView.generatorButton.addTarget(
            self,
            action: #selector(generatorButtonTapped),
            for: .touchUpInside
        )
        homeView.favouriteButton.addTarget(
            self,
            action: #selector(favouriteButtonTapped),
            for: .touchUpInside
        )
        homeView.textField.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged
        )
    }
    
    @objc private func generatorButtonTapped() {
        guard let inputView = homeView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !inputView.isEmpty else {
            return
        }
        let text = String(inputView).replacingOccurrences(of: " ", with: "%20")
        let urlAPI = "https://dummyimage.com/400x400/000/ffffff&text=\(text)"
        
        DataProvider.shared.downloadImage(url: urlAPI) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let image):
                self.loadImage = image
                self.homeView.generatorImageView.image = self.loadImage
                self.homeView.favouriteButton.isEnabled = true
                self.homeView.favouriteButton.backgroundColor = .systemBlue
            case .failure(_):
                let alert = errorAlert(title: "Invalid characters",
                                       message: "Remove invalid characters from the request"
                )
                self.present(alert, animated: true)
            }
        }
        view.endEditing(true)
        self.homeView.textField.text = nil
    }
    
    @objc private func favouriteButtonTapped() {
        if let imageData = loadImage.pngData() {
            DataBaseHelper.shared.saveImage(data: imageData)
            
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

    private func errorAlert(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionOK)
        return alert
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
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyBoardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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
