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

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()

        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addTarget()
        setupDismissKeyboardGesture()
        registerForKeyboardNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Private

    private func errorAlert(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: Constants.alertActionTitleOK, style: .default)
        alert.addAction(actionOK)
        return alert
    }

    // MARK: - Actions

    @objc private func generatorButtonTapped() {
        guard let inputView = homeView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !inputView.isEmpty else {
            return
        }
        let text = String(inputView).replacingOccurrences(of: " ", with: "%20")
        let urlAPI = Constants.url + text

        DataProvider.shared.downloadImage(url: urlAPI) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let image):
                self.loadImage = image
                self.homeView.generatorImageView.image = self.loadImage
                self.homeView.favoriteButton.isEnabled = true
                self.homeView.favoriteButton.backgroundColor = .systemBlue
            case .failure(let error):
                switch error {
                case .badURL:
                    let alertUrl = errorAlert(
                        title: Constants.errorURLAlertTitle,
                        message: Constants.errorURLAlertMessage
                    )
                    self.present(alertUrl, animated: true)
                case .requestError:
                    let alertRequest = errorAlert(
                        title: Constants.errorRequestAlertTitle,
                        message: Constants.errorRequestAlertMessage
                    )
                    self.present(alertRequest, animated: true)
                }
            }
        }
        view.endEditing(true)
        homeView.textField.text = nil
    }

    @objc private func favoriteButtonTapped() {
        DataBaseHelper.shared.saveImage(image: loadImage)
    }

    @objc private func textFieldChanged() {
        if homeView.textField.text != nil {
            homeView.generatorButton.isEnabled = true
            homeView.generatorButton.backgroundColor = .systemBlue
        } else {
            homeView.generatorButton.isHidden = false
        }
    }

    private func addTarget() {
        homeView.generatorButton.addTarget(
            self,
            action: #selector(generatorButtonTapped),
            for: .touchUpInside
        )
        homeView.favoriteButton.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
            for: .touchUpInside
        )
        homeView.textField.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged
        )
    }
}

// MARK: - Keyboard

extension HomeViewController {
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }

    @objc private func viewTapped(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.ended {
            view.endEditing(true)
        }
    }

    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        if let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue  {
            let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
            homeView.scrollView.contentInset = edgeInsets
            homeView.scrollView.scrollIndicatorInsets = edgeInsets
        }
    }

    @objc func keyboardHideShow() {
        homeView.scrollView.contentOffset = CGPoint.zero
    }
}
