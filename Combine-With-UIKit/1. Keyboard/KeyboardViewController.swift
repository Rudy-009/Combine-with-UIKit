//
//  KeyboardViewController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import UIKit
import Combine

class KeyboardViewController: UIViewController {
    
    private let keyboardView = KeyboardView()
    private let viewModel = KeyboardViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        self.view = keyboardView
        hideKeyboardWhenTappedAround()
        self.setActions()
    }
    
    private func setActions() {
        // UITextField를 Combine Publisher로 변환
        keyboardView.textField.textDidChangePublisher()
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
            UIAction { [weak self] _ in
                self?.cancellables.removeAll() // 다른 뷰로 넘어갈 때, 쓰면 좋을 코드
            },
            for: .touchUpInside)
    }
}
