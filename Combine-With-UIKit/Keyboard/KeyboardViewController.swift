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
        keyboardView.textField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        
         viewModel.$input
            .sink {
                if $0.count > 5 {
                    self.keyboardView.button.available()
                } else {
                    self.keyboardView.button.unavailable()
                }
            }
            .store(in: &cancellables)
        
        keyboardView.button.addAction(UIAction { // 요구사항에는 없었지만, 구독을 취소하는 코드를 구현
            [weak self] _ in self?.cancellables.removeAll()},
            for: .touchUpInside)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        viewModel.input = textField.text ?? ""
    }
        
}
