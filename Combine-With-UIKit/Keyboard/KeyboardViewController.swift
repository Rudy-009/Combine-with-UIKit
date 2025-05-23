//
//  KeyboardViewController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import UIKit
import Combine

class KeyboardViewController: UIViewController, UITextFieldDelegate {
    
    private let keyboardView = KeyboardView()
    private let viewModel = KeyboardViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        self.view = keyboardView
        keyboardView.textField.delegate = self
        self.setActions()
    }
    
    private func setActions() {
        // UITextField를 Combine Publisher로 변환
        keyboardView.textField.textPublisher()
            .assign(to: \.input, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.$isInputValid
            .sink { [weak self] isValid in
                if isValid {
                    self?.keyboardView.button.available()
                } else {
                    self?.keyboardView.button.unavailable()
                }
            }
            .store(in: &cancellables)
        
        keyboardView.button.addAction(
            // 요구사항에는 없었지만, 구독을 취소하는 코드를 구현
            UIAction { [weak self] _ in
                self?.cancellables.removeAll() // 다른 뷰로 넘어갈 때, 쓰면 좋을 코드
            },
            for: .touchUpInside)
    }
}

// UITextField를 위한 Publisher 확장
extension UITextField {
    
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }

}
