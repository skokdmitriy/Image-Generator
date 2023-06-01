//
//  HomeViewController.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 01.06.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeView = HomeView()
    
    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupKeyBoardingHiding()
        setupDismissKeyboardGesture()
        homeView.generatorButton.addTarget(self, action: #selector(getImage), for: .touchUpInside)
    }
    
    @objc func getImage() {
        guard let inputView = homeView.textField.text else { return }
        let text = String(inputView)
        
        let api = "https://dummyimage.com/400x400/000/fff&text=\(text)"
        guard let urlAPI = URL(string: api) else { fatalError("someError") }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlAPI) { (data, response, error) in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.homeView.generatorImage.image = image
            }
        }
        task.resume()
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
            return }
        
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
